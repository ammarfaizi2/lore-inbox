Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131661AbRBNVjg>; Wed, 14 Feb 2001 16:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRBNVj0>; Wed, 14 Feb 2001 16:39:26 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:37124 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S131661AbRBNVjO>; Wed, 14 Feb 2001 16:39:14 -0500
From: dilinger@mp3revolution.net
Date: Wed, 14 Feb 2001 16:39:06 -0500
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: piix.c and tuning question
Message-ID: <20010214163906.A2085@incandescent.mp3revolution.net>
In-Reply-To: <20010214023538.A26558@incandescent.mp3revolution.net> <3A8A38E7.569FD70E@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A8A38E7.569FD70E@Home.net>; from Shawn.Starr@Home.net on Wed, Feb 14, 2001 at 02:51:03AM -0500
X-Operating-System: Linux incandescent 2.4.2-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 02:51:03AM -0500, Shawn Starr wrote:
> 
> hmmm this is my chipset:
> 
> Which motherboard do you have?

No clue, it's an old p166, and I'm not about to open up the case..

> 
> 00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
> 00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
> 
> i've had irq timeouts but they were due to a slow CD-ROM causing the two DMA drives to timeout (don't
> know why).
> 
> ive never seen ide_dmaproc though.

Me neither, which is why I initially couldn't figure out what was
wrong..  Since setting -X34, however, I haven't had any more ide problems.

> 
> This is my following hdparm config
> 
> hdparm -d 1 -X34 -u1 -k 1 /dev/hdb
> hdparm -d 1 -X34 -u1 -k 1 /dev/hda

I don't use -k1, since I rely on the OS to set features if something is
messed up.

Has -u1 made much of a difference for you?

> 
> for both drives, one of them us a UDMA66 but this Pentium 200Mhz cant do UDMA even ;/
> 
> I have a AP53/AX AcerOpen Motherboard.
> 
> Shawn.
> 

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com
