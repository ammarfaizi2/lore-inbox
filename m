Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbRGKEpb>; Wed, 11 Jul 2001 00:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbRGKEpV>; Wed, 11 Jul 2001 00:45:21 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61457 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267200AbRGKEpK>; Wed, 11 Jul 2001 00:45:10 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
Date: 10 Jul 2001 21:44:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9igljq$nlu$1@cesium.transmeta.com>
In-Reply-To: <3B4BC5C0.BDDC12A6@home.com> <9igkjl$nk1$1@cesium.transmeta.com> <p05100358b771879535bc@[207.213.214.37]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p05100358b771879535bc@[207.213.214.37]>
By author:    Jonathan Lundell <jlundell@pobox.com>
In newsgroup: linux.dev.kernel
>
> At 9:27 PM -0700 2001-07-10, H. Peter Anvin wrote:
> >  > According to Dave J's utility the cpu's appear to be exactly the same
> >>  just as the Intel boxes said when I bought them.  What might be causing
> >>  these values to be different.  And if the BIOS is setting things up
> >>  incorrectly then why does Dave J's utility show the correct values?
> >>  Thanks for any help.
> >>
> >
> >/proc/cpuinfo shows "cooked" values which may be modified by the
> >kernel, depending on what it knows about CPU errata or kernel
> >capabilities.
> 
> Max cpuid level doesn't get cooked by the kernel, though  (at least 
> not in 2.4.6).
> 
> Level 3 is the Intel's CPU serial number "feature". Didn't Intel back 
> off on that? Maybe that has something to do with it, and perhaps the 
> utility is doing the cooking.
> 

Actually, the kernel kills it if it detects it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
