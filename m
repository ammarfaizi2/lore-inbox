Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUF1IoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUF1IoC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUF1IoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:44:01 -0400
Received: from [213.189.5.208] ([213.189.5.208]:12556 "EHLO yankee.bbid.nl")
	by vger.kernel.org with ESMTP id S264898AbUF1Inm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:43:42 -0400
To: linux-kernel@vger.kernel.org
From: freaky@bananateam.nl
Subject: USB Memory Stick issues (After using it in Wyse Terminal (WindowsCE.NET))
Date: Mon, 28 Jun 2004 08:44:44 GMT
X-Mailer: Endymion MailMan Webmail Free v3.0.29
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - yankee.bbid.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [26 6]
X-AntiAbuse: Sender Address Domain - bananateam.nl
Message-Id: <S264898AbUF1Inm/20040628084342Z+100@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

first off, I'm not on the list, so please CC me.

I'm having some issues with my USB memory stick after using it in a Wyse
Terminal (WS3125SE with Mass Storage Add-On 1.0 Build 9). Let's get things
straight, when I just got the stick it worked just fine, with the partition that
was on there. If I repartition it, it works fine as well.

After I stuck my USB stick into the Wyse terminal I lost all data that was on
it. Appearantly the Wyse Mass Storage Add-On does -not- like a partition on the
device and I think it created some sort of raw file system. This is readable
with the standard driver on Windows 2000/XP and under disk management it says
that there is a partition (FAT) on it. However, if I look under linux it doesn't
show any partitions at all, nor am I able to mount /dev/sda (without partition
number) even when specifying vfat or msdos as the filesystem. On 2.6.6 (now
running 2.6.7) I also had the weird problem that after this happened, linux
would see my drive as a 1GB drive or something whilst it is only a 256MB
(according to cfdisk/fdisk, I saw in the archives others had this problem as
well, haven't checked this before I had it in the Wyse terminal).

Anyways, I'm able to use this stick either under linux and windows with a
partition on it, -or- under wyse terminal and windows, with appearantly no
partition on it. Although disk management under windows does show a partition,
for some strange reason it does not allow you to delete nor create partitions on
usb sticks.

Is there any way I can get it work with this strange filesystem on it? Perhaps
other devices use this 'filesystem?' by default too, as I've seen several tests
where USB sticks did show up as a SCSI device, but weren't able to mount them
and didn't show partitions.

Sorry if this has been asked before, I did a fair share of searching but
couldn't dig up anything that seems related to this problem.

If I can help in any way please let me know.

Kind regards,

Ferry van
Steen

---------------------------------------------
Dit bericht is verzonden via Postbakje Free.
http://www.postbakje.nl/ - Gratis WebMail


