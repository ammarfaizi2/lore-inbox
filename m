Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSIOTHT>; Sun, 15 Sep 2002 15:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSIOTHT>; Sun, 15 Sep 2002 15:07:19 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:38606 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S318219AbSIOTHQ>; Sun, 15 Sep 2002 15:07:16 -0400
From: "syam" <syam@cisco.com>
To: <kernelnewbies@nl.linux.org>, <adilger@turbolabs.com>,
       <thunder@lightweight.ods.org>, <rz@linux-m68k.org>,
       <linux-kernel@vger.kernel.org>
Subject: ext2_check_page error
Date: Sun, 15 Sep 2002 12:10:31 -0700
Message-ID: <BOEAKBEECIJEDIMOJJJOOEHGCEAA.syam@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
I doing the following sequence of events:
1. Tarred the directories of an existing system.
2. Booted my development system from a ramdisk using a rescue image.
3. fdisk /dev/hda and created a partition accepting the defaults.
4. cd /; mkdir j; mke2fs -cv /dev/hda1; mount -t ext2 /dev/hda1 /j;
5. Downloaded the tar, my compiled image and whole bunch of RPMs I need to
install on the system.
6. Reboot and I made the system boot from hard drive. I get this error when
I am installing the RPMs:

"EXT2-fs error (device ide0(3,1)); ext2_check_page: bad entry in
directory #30979: unaligned directory entry - offset=920,
inode=1388815025, rec_len=53409, name_len=47"

I ran memtest and my memory seems to be working fine. I am using kernel
2.4.19. Is this a bug in the kernel or am I doing anything wrong? Can
someone explain?

Regards,
Syam

