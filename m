Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSGFWNo>; Sat, 6 Jul 2002 18:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSGFWNn>; Sat, 6 Jul 2002 18:13:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14859 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312962AbSGFWNn>; Sat, 6 Jul 2002 18:13:43 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [OT] /proc/cpuinfo output from some arch
Date: 6 Jul 2002 15:16:07 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ag7q77$en7$1@cesium.transmeta.com>
References: <003201c224cd$e25df820$0201a8c0@witek> <jen0t4g35k.fsf@sykes.suse.de> <20020706221205.A5242@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020706221205.A5242@flint.arm.linux.org.uk>
By author:    Russell King <rmk@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> On Sat, Jul 06, 2002 at 07:46:47PM +0200, Andreas Schwab wrote:
> > Processor	: Intel StrongARM-110 rev 4 (v4l)
> 
> Note that this could also be something like:
> 
> Processor	: ARM/VLSI Arm1020id(wb)BRR rev 1 (v4)
> 
> or:
> 
> Processor	: ARM ARM926EJ-Sid(wb)RR rev 2 (v5)
> 
> It might change further if the manufacturer decides to have a space
> in their name.  Basically, /proc/cpuinfo was never meant to be passed
> by programs, and its not something I'd like to support with the current
> format.
>  

/proc/cpuinfo was *definitely* meant to be parsed by programs.
Unfortunately, lots of architectures seems to have completely missed
that fact.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
