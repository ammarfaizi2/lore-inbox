Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbQLROa5>; Mon, 18 Dec 2000 09:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQLROah>; Mon, 18 Dec 2000 09:30:37 -0500
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:50948
	"EHLO hp.masroudeau.com") by vger.kernel.org with ESMTP
	id <S129631AbQLROa0>; Mon, 18 Dec 2000 09:30:26 -0500
Date: Sun, 17 Dec 2000 22:17:49 -0800 (PST)
From: Etienne Lorrain <etienne@masroudeau.com>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Gujin-0.2 boot/Linux system loader
Message-ID: <Pine.LNX.4.30.0012172152580.18556-100000@hp.masroudeau.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,

 I have uploaded on:
http://sourceforge.net/projects/gujin/
 a new version of my bootloader. It loads and analyse a vmlinuz
 file (do not need LILO) selected by the user using a graphical
 menu (up to 1600x1200 32 BPP) and a mouse (serial or PS2).
 It find all possible vmlinuz* by scanning FAT12/FAT16 and E2FS
 partitions using BIOS/EBIOS/IDE drivers.

 Right now it can only be installed on a floppy disk so there is
 no risk of crashing the tester's partition table (the code to
 write to hard drive is not included).

 It is written in C with GCC and execute in real mode. It is GPL.

 There is a HowTo (containing a FAQ) here:
http://sourceforge.net/docman/?group_id=15465

 I would be nice if some of you (having 5 minutes and a spare 1.44M
 floppy) download the 5 minutes test at:
http://sourceforge.net/project/showfiles.php?group_id=15465&release_id=18235
 and report bugs/success story (maybe not on this list).
 Just "zcat boot144.img.gz > /dev/fd0" and reboot.

 It is neither finished nor perfect, but should work on any
 "standart PC".

 Sorry to be little off-topic.
 Etienne.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
