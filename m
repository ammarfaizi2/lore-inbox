Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbRDZBgU>; Wed, 25 Apr 2001 21:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133050AbRDZBgL>; Wed, 25 Apr 2001 21:36:11 -0400
Received: from p0007.as-l042.contactel.cz ([194.108.237.7]:385 "EHLO
	p0007.as-l042.contactel.cz") by vger.kernel.org with ESMTP
	id <S133047AbRDZBgI>; Wed, 25 Apr 2001 21:36:08 -0400
Date: Thu, 26 Apr 2001 03:36:43 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Nathan Walp <faceprint@faceprint.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: random reboots
Message-ID: <20010426033643.L1125@ppc.vc.cvut.cz>
In-Reply-To: <3AE5A762.675581E4@faceprint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AE5A762.675581E4@faceprint.com>; from faceprint@faceprint.com on Tue, Apr 24, 2001 at 12:18:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 12:18:42PM -0400, Nathan Walp wrote:
> I upgraded the BIOS on this Asus A7V sometime in the past week, but I
> honestly don't remember when.  From 1005C to 1007.  This was released in
> march, so I assumed it was pretty stable, but it could be the cause. 
> I'm going to go downgrade now, but is this more likely to be a kernel
> bug, or a hardware bug/new bios bug?

No problem here. I'm using 1007 since its release in first half
of March.

Linux version 2.4.3-ac12-amd (root@ppc) (gcc version 3.0 20010402 (Debian prerelease)) #1 Mon Apr 23 02:31:13 CEST 2001
...
Kernel command line: BOOT_IMAGE=Linux ro root=2105 video=matrox:vesa:0x105,fv:85 devfs=nomount
Initializing CPU#0
Detected 1009.013 MHz processor.
...
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
...
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
...

Except that I got 'ide only func: 14' today with my Promise PDC20265
(which looks strange to me - either all Intel, VIA and Promise have
same bug in their UDMA hardware, or there is a bug in Linux IDE 
driver...) (I had to reboot because of kernel somehow believed that
it read some garbage instead of MBR from hdg, so I could not run my 
repartitioning session, as I found no way to invalidate hdg kernel
cache). 
But machine for sure does not spontaneously reboot. And I have 
enabled local apic in kernel configuration. All previous kernels
were built with Debian's 2.95.3-something, ac12 was built with
gcc-3.0, as I wanted to update anyway, and ac12 just gave me a reason.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

