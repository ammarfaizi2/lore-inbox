Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSBUI4y>; Thu, 21 Feb 2002 03:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290587AbSBUI4n>; Thu, 21 Feb 2002 03:56:43 -0500
Received: from vaak.stack.nl ([131.155.140.140]:62479 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S289813AbSBUI4c>;
	Thu, 21 Feb 2002 03:56:32 -0500
Date: Thu, 21 Feb 2002 09:56:30 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: peter@hoeg.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: misdetection of pentium2 - very strange
In-Reply-To: <1014276172.3c74a04c7565e@www.hoeg.home>
Message-ID: <20020221094949.A86349-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Feb 2002 peter@hoeg.com wrote:

> dmesg:
>
> Linux version 2.4.18-rc2 (peter@asilog-linux2) (gcc version 2.95.4 (Debian
> prerelease)) #3 Thu Feb 21 19:21:37 SGT 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
>  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> On node 0 totalpages: 49152
> zone(0): 4096 pages.
> zone(1): 45056 pages.
> zone(2): 0 pages.
> Kernel command line: auto BOOT_IMAGE=linux ro root=301 devfs=mount
> video=atyfb:1024x768@8
> Initializing CPU#0
> Detected 133.225 MHz processor.
> Console: colour VGA+ 132x44
> Calibrating delay loop... 265.42 BogoMIPS

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It seems your CPU is actually running at 133 MHz. If I am right, the
bogomips value should be about 2x the clock frequency on this CPU and
kernel. Is the bogomips calculation influenced by the detected CPU speed ?
Can't check now.

Can it be your system runs in a low-power mode, or that the linux kernel
triggers a low-power mode ?

Jos

