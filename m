Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTARPLx>; Sat, 18 Jan 2003 10:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTARPLx>; Sat, 18 Jan 2003 10:11:53 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:4100 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S264797AbTARPLw>;
	Sat, 18 Jan 2003 10:11:52 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "Mark F." <daracerz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 - Compaq 900z - No Go..
References: <BAY2-DAV69nJkxWwBvt0000440f@hotmail.com>
	<20030118132807.GC21489@codemonkey.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Jan 2003 16:20:41 +0100
In-Reply-To: <20030118132807.GC21489@codemonkey.org.uk>
Message-ID: <87lm1iiiwm.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> On Fri, Jan 17, 2003 at 11:49:10AM -0500, Mark F. wrote:
>  > Hello
>  > 
>  > After trying the recent latest release, the compilation mode is an ok except
>  > for some warning and module install issues.
>  > Anyways, when I configure the kernel into the boot loader, and I try to boot
>  > it up it fails after each repeated attempt.  All that happens is that it
>  > starts the Kernel Boot Up, gets to the line that says "Uncompressing
>  > Kernel...." and the it just hard reboots the computer.  Does this after each
>  > repeated chance.  Currently trying to play around with whch drivers I am
>  > loading into the kernel to see if I am able to eliminate something
>  > 
>  > Computer is basically an AMD Athlon 1600 with the Radeon IGP Chipset for
>  > those who don't know.  (Yes, with previous builds, think was 2.5.54 is
>  > booted, and works on 2.4.21-pre3)
> 
> My Compaq Evo 1015v did the same thing. I think it was disabling the PNP
> stuff that made it work for me iirc.
> 

Comapq Evo800c here, boots somewhat fine. 2.5.58 hung at
"Uncompressing, booting...", 2.5.59 did almost the same, but then I
noticed the disk actually doing stuff, and by waiting, up popped the
"login:" promt after a while, but nothing was printed to the console
during boot.

I have module-init-tools 0.9.9_pre1 installed, and get about 2000
lines in my /var/log/messages with mostly soudn and alsa related
symbols that doesn't resolve.

> 		Dave

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
