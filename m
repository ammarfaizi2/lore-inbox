Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRAPDsk>; Mon, 15 Jan 2001 22:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbRAPDsb>; Mon, 15 Jan 2001 22:48:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129747AbRAPDsR>; Mon, 15 Jan 2001 22:48:17 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] i386/setup.c cpuinfo notsc
Date: 15 Jan 2001 19:47:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <940g9e$5uq$1@cesium.transmeta.com>
In-Reply-To: <3A636E77.3A409B17@transmeta.com> <Pine.GSO.3.96.1010115224843.16619d-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.3.96.1010115224843.16619d-100000@delta.ds2.pg.gda.pl>
By author:    "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In newsgroup: linux.dev.kernel
>
> On Mon, 15 Jan 2001, H. Peter Anvin wrote:
> 
> > Right, but I'd also like to see the global flags exported explicitly to
> > /proc/cpuinfo.
> 
>  That's desirable, but how would we fit it into the existing layout? 

I was thinking of having a global section at the top, without a
"Processor:" header.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
