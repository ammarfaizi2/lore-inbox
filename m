Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281530AbRLAJWV>; Sat, 1 Dec 2001 04:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284016AbRLAJWL>; Sat, 1 Dec 2001 04:22:11 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:822 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S281530AbRLAJWC> convert rfc822-to-8bit; Sat, 1 Dec 2001 04:22:02 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
Date: Sat, 1 Dec 2001 10:20:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E16A6LR-00042s-00@mrvdom02.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.4.16 to 2.4.17pre2 I got the following message in 
dmesg:

.
parport0: assign_addrs: aa5500ff(80)
parport_pc: Via 686A parallel port: io=0x378
devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
lp0: using parport0 (polling).
.

or 

devfs: devfs_register(nvidiactl): could not append to parent, err: -17
devfs: devfs_register(nvidia0): could not append to parent, err: -17


with 2.4.16 and before the message was:

devfs: devfs_register(): device already registered: "nvidia0"


Why has this changed, and what is actually happen? My system runs fine.

greetings

Christian Bornträger
