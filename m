Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282829AbRLORfz>; Sat, 15 Dec 2001 12:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282821AbRLORfq>; Sat, 15 Dec 2001 12:35:46 -0500
Received: from maile.telia.com ([194.22.190.16]:2760 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S282829AbRLORfe>;
	Sat, 15 Dec 2001 12:35:34 -0500
Date: Sat, 15 Dec 2001 18:35:29 +0100 (MET)
From: Jurij Smakov <jurij.smakov@telia.com>
X-X-Sender: jurij@bobcat
To: linux-kernel@vger.kernel.org
Subject: PDC20265 IDE controller trouble
Message-ID: <Pine.GHP.4.43.0112151828220.9103-100000@bobcat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Recently I've got an Asus TUSL2 motherboard, which has an extra Promise
IDE RAID controller with a PDC20265 chip. I've connected two IBM 60 GB
disks to it (one disk per channel). I am using kernel 2.4.17-pre8
(with CONFIG_BLK_DEV_PDC202XX=y and with/without CONFIG_PDC202XX_BURST=y),
which nicely detects the extra controller and both disks, hde and hdg. If
I test the writing and reading speed (hdparm -t, dd if=/dev/zero of=test
...) separately for each disk, I get the expected figures, like 36-37
MB/sec for reading, about 30 MB/sec for writing. If, however, I try to
write simultaneously to both disks, the performance drops drastically. The
rate for writing is then something like 3.5 MB/sec (!). I wonder if anyone
have seen anything like that or might have any ideas on how to solve the
problem.

Suspecting the hardware, I've posted this message to
comp.os.linux.hardware first, but no one have seen such a behaviour. I
have also tried different sets of IDE cables.

Best regards and TIA,


Jurij.

P.S. Please cc responses to me, because I'm not on the list.

