Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277556AbRJETFk>; Fri, 5 Oct 2001 15:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277551AbRJETFa>; Fri, 5 Oct 2001 15:05:30 -0400
Received: from dns4.captainjack.com ([63.69.184.4]:28758 "HELO
	dns4.captainjack.com") by vger.kernel.org with SMTP
	id <S277550AbRJETFQ>; Fri, 5 Oct 2001 15:05:16 -0400
Message-ID: <001e01c14dd0$326264d0$2a23b1cf@win2k>
From: "Tyler Longren" <tyler@captainjack.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.x, smp, eepro100
Date: Fri, 5 Oct 2001 14:01:52 -0500
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

Hello everyone,

I've been having major troubles with a machine here.  Here's my setup:

OS: Slackware 8.0
Kernel: 2.4.5_nosmp, 2.4.5, and 2.4.10
NIC: eepro100

Anyway, installed Slackware with the default scsi kernel.  Everything worked
fine.  I re-compiled 2.4.5 to enable smp support.  After re-compiling
everything is stable until a few hundred megs gets uploaded to the box.
After a few hundred megs get upped to the box (through ftp), eth0 just dies.
The same thing happened in 2.4.9 and now also happens in 2.4.10.  There's
some odd messages coming from dmesg:
eth0:        8   0000a022.
eth0:        9   0000a020.
eth0:        10 0000a020.
eth0:        11 0000a020.
eth0:        12 0000a022.
eth0:        13 0000a022.
eth0:        14 0000a020.
eth0:        15 0000a020.
eth0:        16 0000a020.
eth0:        17 00000001.
eth0:        18 00000001.

I have no idea why this is happening.  My ethernet card uses the eepro100
module.  When I re-compile the kernel, I use the default config file for
slackware (so it should be like the default Slackware scsi kernel).  The
only thing I do is add SMP support.

Any ideas anyone?

Thanks,
Tyler Longren


