Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271884AbRIDOPk>; Tue, 4 Sep 2001 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271878AbRIDOPb>; Tue, 4 Sep 2001 10:15:31 -0400
Received: from www.collins-maxwell.k12.ia.us ([199.120.112.209]:6916 "EHLO
	bdc.collins-maxwell.k12.ia.us") by vger.kernel.org with ESMTP
	id <S271884AbRIDOPT>; Tue, 4 Sep 2001 10:15:19 -0400
Message-ID: <008801c1354b$94c803c0$2a23b1cf@win2k>
From: "Tyler Longren" <tyler@captainjack.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.9, reiserfs, and multiple hdds
Date: Tue, 4 Sep 2001 09:12:07 -0500
Organization: Captain Jack Communications
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this to the Slackware forum yesterday.  It was suggested that I
post to the kernel mailing list.  So, here's the problem:

Here's my problem:

System Setup:
----------------
OS: Slackware Linux 8.0
Kernel: 2.4.9
ProFTPD: 1.2.2rc3
FS: ReiserFS
Multiple hdd's mounted on /storage

Problem:
---------
When uploading to /storage (when the box is running 2.4.5), there's no
problems at all. But
when I compile 2.4.9, reboot, and upload to /storage again, everything goes
to hell from there.
I get a bunch of these messages:
eth0: 22 00000001
eth0: 23 00000001
eth0: 24 00000001

I've also gotten this before:
eth0 25 0000a020
eth0 26 0000a020
eth0 27 0000a020

After this goes on for a few minutes, the box comes to a grinding halt (it
segfaults, and stops
moving).

When I don't upload to /storage, say I up to /home/tyler instead, there's no
problems (I assume
because only one hdd is mounted on /home).

When I compiled 2.4.9, I used the config file found in /boot/config
(installs w/ Slackware). I
did change a few things though, like:
1. Added SMP support
2. Removed NTFS support so 2.4.9 would compile
3. Removed Road Runner (network device) support to 2.4.9 would compile


If more information is needed, please let me know, I'll get what I can.

Thanks everyone,
Tyler Longren


