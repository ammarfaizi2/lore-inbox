Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQJaTRD>; Tue, 31 Oct 2000 14:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbQJaTQx>; Tue, 31 Oct 2000 14:16:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38405 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129371AbQJaTQf>; Tue, 31 Oct 2000 14:16:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test10-pre7
Date: 31 Oct 2000 11:16:25 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tn5q9$iu5$1@cesium.transmeta.com>
In-Reply-To: <39FF0A71.FE05FAEB@gromco.com> <Pine.LNX.4.10.10010311018180.7083-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10010311018180.7083-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Does anybody see any problems with it? Basically, we're sidestepping the
> sorting, because neither SCSI nor USB need it. Making the problem simpler
> is always good.
> 
> Now, the above won't work for drivers/net, but I think it will work for
> just about anything else. So let's just leave drivers/net alone for now.
> Simplicity is good.
> 

I was going to ask to what extent we genuinely need sorting, and if we
might be better off trying to eliminate that need as much as possible.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
