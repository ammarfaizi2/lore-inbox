Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSHBVBm>; Fri, 2 Aug 2002 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSHBVBm>; Fri, 2 Aug 2002 17:01:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316916AbSHBVBm>;
	Fri, 2 Aug 2002 17:01:42 -0400
Date: Fri, 2 Aug 2002 14:03:02 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: David Ford <david+cert@blue-labs.org>,
       <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] Re: Linux booting from USB HD / USB interface
 devices
In-Reply-To: <20020728123329.C12344@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.33L2.0208021348560.14068-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Matthew Dharm wrote:

| On Sun, Jul 28, 2002 at 11:40:01AM -0400, David Ford wrote:
| > Thank you for your reply.  I've started a rough draft of this project,
| > http://blue-labs.org/ranger.php

Not much progress so far?

[snip]
| > >THe stock kernel won't work.  There are patches floating around to make
| > >this work.  Basically, the kernel needs to pause for a couple of seconds
| > >before attempting to mount the root fs so that the plug-n-pray detection
| > >can work, identify the drive, and get going.
| > >
| >
| > I'll go look for these patches, pointers are welcome of course.
|
| Sorry, no pointers.  See if you can find a linux-usb-devel or
| linux-usb-users archive.  You're searching for something that introduces a
| "delay" (good keyword) in the boot process.

There have been 2 such patches that I know of.

a. One is from Eric Lammerts (subj: Using USB floppy drive for root floppy)
on Dec. 23, 2001 (on the linux-kernel mailing list).
<http://marc.theaimsgroup.com/?l=linux-kernel&m=100912381726661&w=2>

b. 2001-10-26: Booting a USB disk:
<http://marc.theaimsgroup.com/?l=linux-usb-users&m=100408963708374&w=2>

Neither of these patches will apply cleanly to 2.4.1[89].
I am working with 'a.'.
It now applies and builds cleanly, so I'm trying to test it.

My turn for a question:
What files do I need to copy to a USB boot disk to be able to
successfully boot a Linux kenrel?
I'm already building the kernel with usb-storage support and all of
the required SCSI support in the kernel.

Won't I need to put the kernel as the primary boot image,
i.e., don't use a boot loader on the USB storage device,
since the boot loader won't have USB storage I/O capabilities?

Does anyone know of a HOWTO for this?
I'm currently trying to use the zip-install and/or install-from-zip
mini-howtos.

-- 
~Randy

