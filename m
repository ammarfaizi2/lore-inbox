Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbRBBPZA>; Fri, 2 Feb 2001 10:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129275AbRBBPYu>; Fri, 2 Feb 2001 10:24:50 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:37873 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129233AbRBBPYn>; Fri, 2 Feb 2001 10:24:43 -0500
Message-Id: <5.0.2.1.2.20010202151231.00a43d00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 02 Feb 2001 15:24:32 +0000
To: "Tom Sightler" <ttsig@tuxyturvy.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 3Com 3c523 in IBM PS/2 9585: Can't load module in kernel
  2.4.1
Cc: "Michael Pacey" <michael@wd21.co.uk>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <001a01c08bf0$74c47d60$02c8a8c0@zeusinc.com>
In-Reply-To: <20010201193250.B340@kermit.wd21.co.uk>
 <E14ORB4-000571-00@the-village.bc.nu>
 <20010201220624.E340@kermit.wd21.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > eth0: memprobe, Can't find memory at 0xc0000!

I get the same memprobe error. Haven't bothered with it for some time as I 
had problems getting the IBMMCASCSI recognized in 2.4.x but that seems to 
have been fixed now.

>I have patches that I believe fix this, but their own my box at home that I
>can't get do right now.  When I get back from LinuxWorld tomorrow I'll pull
>them off and post them.

Can't wait. Once I get this working I should be able to get Linux installed 
on this old PS/2 box. Can't remember the model number off hand as I am in 
the lab at the moment but it's a 486DX2/50 with 10 (or 12) Mib RAM, a 
300Mib SCSI disk or so with 3c523 ethernet card attached to a AUI-RJ45 
transceiver and then to a 10Mbit hub (works under DOS) and two graphics 
cards (the internal one and an additional XGA/2 IIRC). Should make a nice 
MCA test system once I get it networked and can install Linux on it... And 
a nice serial console for kernel debugging, for that matter. (-:

>Even if you don't use the card, it's be nice to have another user test it
>out before I submit the patch.

I definitely will use it. You have just found another keen to test the 
patch person. (-:

Anton


-- 
"I strongly believe that trying to be clever is detrimental to your 
health." - Linus Torvalds
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
