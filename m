Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319325AbSIGEbW>; Sat, 7 Sep 2002 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSIGEbW>; Sat, 7 Sep 2002 00:31:22 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:5325 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S319325AbSIGEbV>; Sat, 7 Sep 2002 00:31:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eli <eli@pflash.com>
To: linux-kernel@vger.kernel.org
Subject: IO errors: SanDisk ImageMate USB CF, SD, MMC reader
Date: Fri, 6 Sep 2002 23:37:37 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17nXKB-0004DB-00@albatross.prod.itd.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Problem Summary:
I have a SanDisk ImageMate USB compactFlash + SecureDigital + MultiMediaCard 
reader, and I am getting IO errors trying to read a 128MB SimpleTech CF card 
with 2.4 kernels.

Details:

I have an 8MB Canon CF card and a 128MB SimpleTech CF card.

With the USB reader, I see:
OS or Device      | 8MB | 128MB |
------------------+-----+-------+
MacOS 9           |  OK |   OK  |
RH 2.4.17-0.16smp |  OK |  ERR  |
RH 2.4.18-3       |  OK |  ERR  |

ERR means that I get IO errors when I try to 'cp -a' the contents of the CF 
card to local disk.
"pc: reading '/mnt/flash1.....': Input/output error" is repeated for many of 
the files on the card, but not all of them.  Most of them seem to be later 
files.

Also, with a PCMCIA adapter in the RH 2.4.18-3, both CF cards work.
Both cards also work in a HandEra 300 PDA and a Canon PowerShot A40 digital 
camera.

Any suggestions of how I could track down the problem?  (I've submitted a bug 
report to SanDisk as well, but this looks like a Linux problem to me.)

(Please CC me as I am not subscribed here at home.)

Eli Carter
retracile(a)earthlink.net
