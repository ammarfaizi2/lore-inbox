Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130340AbQKVI4t>; Wed, 22 Nov 2000 03:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQKVI4k>; Wed, 22 Nov 2000 03:56:40 -0500
Received: from [204.229.122.220] ([204.229.122.220]:2180 "EHLO eye.micron.net")
	by vger.kernel.org with ESMTP id <S130340AbQKVI40>;
	Wed, 22 Nov 2000 03:56:26 -0500
Message-ID: <007d01c0545d$e6444760$53b613d1@micron.net>
From: "Joe Harrington" <jharring@micron.net>
To: "CSCD 440-01 Mailing List" <cs440@tux.ewu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: filesystems
Date: Wed, 22 Nov 2000 00:26:22 -0800
Organization: Software Solutions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-SMTP-HELO: micron
X-SMTP-MAIL-FROM: jharring@micron.net
X-SMTP-PEER-INFO: [209.19.182.83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does a typical Linux system or Mandrake boot using the ext2 filesystem? Do
all filesystems have or use commands such as stat, read, write and chmod. I
am trying to figure out without looking through the code how a VFS
filesystem works. I am assuming that it does not use the major minor system,
for faster access to data? On my system I have:

            ext2
            msdos
nodev proc

Yes I did a man filesystems, man virtual filesystems, and manVFS. What does
the nodev stand for? I have seen other systems containing filesystems such
as:

            ext2
            minix
            msdos
            vfat
nodev proc
nodev nfs
            iso9660
            ufs
nodev autofs
nodev devpts

Basically, do you mount a VFS filesystem, does it keep pages in RAM longer
than other filesystems. How would a VFS filesystem handle system calls such
as "stat" or "open"? I am just looking for something that can easily help me
visualize the VFS process.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
