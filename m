Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130050AbRCDNZd>; Sun, 4 Mar 2001 08:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130051AbRCDNZY>; Sun, 4 Mar 2001 08:25:24 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20336 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130050AbRCDNZN>; Sun, 4 Mar 2001 08:25:13 -0500
Message-ID: <001b01c0a4ae$6c236e60$3201a8c0@laptop>
From: "Christian Hilgers" <webmaster@server-side.de>
To: <linux-kernel@vger.kernel.org>
Subject: DVD Problem
Date: Sun, 4 Mar 2001 14:24:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use the 2.4.1 Kernel but I have some troubles with my
ATAPI Matsushita UJDA510 DVD (Intel 82371AB/EP PCI Bus Master IDE
Controler).
It works perfekt with CD-Rom but when I try to read a ISO 9660 DVD I got
an error.

I can mount the DVD and I can list the complet content but I guess I
can't access any File behind 650 MB.

e.g.

mount /cdrom
$ cat /cdrom/blah/blah/INDEX
cat: INDEX.german: Input/output error

The kernel log
Mar  3 18:45:06 laptop kernel: VFS: Disk change detected on device
ide1(22,0)
Mar  3 18:45:10 laptop kernel: ISO 9660 Extensions: RRIP_1991A
Mar  3 18:46:05 laptop kernel: attempt to access beyond end of device
Mar  3 18:46:05 laptop kernel: 16:00: rw=0, want=2855480, limit=1052700

It also works well with a 2.2.14-SuSE Kernel.

Any hints.

Thanks
Christian

