Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSLGUuZ>; Sat, 7 Dec 2002 15:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSLGUuZ>; Sat, 7 Dec 2002 15:50:25 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:16886 "EHLO
	mail41.fg.online.no") by vger.kernel.org with ESMTP
	id <S264749AbSLGUuY>; Sat, 7 Dec 2002 15:50:24 -0500
Date: Sat, 7 Dec 2002 21:58:22 +0100
From: Michael <soppscum@online.no>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-xfs loop device problem
Message-Id: <20021207215822.38e765a2.soppscum@online.no>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixed the oops I got previously.
But I still get this error :

spam michael # mount -o loop stuff/linux-cd/knoppix/orig/KNOPPIX_V3.1-08-11-2002-EN.iso /mnt/iso
/dev/loop0: Input/output error
mount: you must specify the filesystem type

dmesg output :
Buffer I/O error on device loop(7,0), logical block 0
Buffer I/O error on device loop(7,0), logical block 1
Buffer I/O error on device loop(7,0), logical block 2
Buffer I/O error on device loop(7,0), logical block 3
Buffer I/O error on device loop(7,0), logical block 4
Buffer I/O error on device loop(7,0), logical block 5
Buffer I/O error on device loop(7,0), logical block 6
Buffer I/O error on device loop(7,0), logical block 7
Buffer I/O error on device loop(7,0), logical block 8
Buffer I/O error on device loop(7,0), logical block 9
Buffer I/O error on device loop(7,0), logical block 10
Buffer I/O error on device loop(7,0), logical block 11
Buffer I/O error on device loop(7,0), logical block 12
Buffer I/O error on device loop(7,0), logical block 13
Buffer I/O error on device loop(7,0), logical block 14
Buffer I/O error on device loop(7,0), logical block 15
Buffer I/O error on device loop(7,0), logical block 0


Thanks.
