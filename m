Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRAOVpO>; Mon, 15 Jan 2001 16:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRAOVoy>; Mon, 15 Jan 2001 16:44:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8979 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131644AbRAOVon>; Mon, 15 Jan 2001 16:44:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MTRR type AMD Duron/intel ?
Date: 15 Jan 2001 13:44:00 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <93vqv0$l34$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0101151937460.8658-100000@svea.tellus> <Pine.LNX.4.10.10101151151080.6408-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10101151151080.6408-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> On Mon, 15 Jan 2001, Tobias Ringstrom wrote:
> > 
> > Last time I checked this was issued for perfectly known and valid bridges
> > that advertice no IO resources.  Isn't it a bit silly to issue that
> > warning for that case, or am I missing something?
> 
> Ehh - so what do they bridge, then?
> 
> I'd say that a bridge that doesn't seem to bridge any IO or MEM region,
> yet has stuff behind it, THAT is the silly thing. Thus the "silly"
> warning.
> 

What kind of bridge?  Depending on the kind of bridge, it could be a
subtractive-decoding bridge; or it could be a Host Bridge, which
normally advertise only the resources it needs for itself.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
