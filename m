Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbREOLmK>; Tue, 15 May 2001 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262746AbREOLmA>; Tue, 15 May 2001 07:42:00 -0400
Received: from m3d.uib.es ([130.206.132.6]:13496 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S262744AbREOLlz>;
	Tue, 15 May 2001 07:41:55 -0400
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Reiserfs, Mongo and CPU question
Date: Tue, 15 May 2001 13:41:01 +0200
Message-ID: <NDBBKGPFCLNOBENJJLDDIEBCCHAA.gallir@uib.es>
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

Hans and reiserfs developers,
	the same student of my university
(http://www.cs.helsinki.fi/linux/linux-kernel/2001-18/0654.html) was
carrying up the mongo benchmarks against reiser, xfs, jfs and ext2 for
different base sizes.


For example, for the base size of 10.000 (the average of a clean
distribution is about 16.000 bytes) ReiserFS is even slower than ext2. I've
realised the bottleneck may be the CPU, a Cyrix MII 233MHz.

FSYS=ext2 FSYS=reiserfs

(time in sec.)
Create    32.72 / 56.90 = 0.58
Fragm.    1.49 / 2.22 = 0.67

Copy    98.53 / 131.81 = 0.75
Fragm.    1.49 / 2.26 = 0.66

Slinks    4.82 / 5.08 = 0.95
Read    187.90 / 299.23 = 0.63
Stats    1.01 / 0.99 = 1.02
Rename    2.40 / 2.23 = 1.08
Delete    6.55 / 4.82 = 1.36


Can you confirm it? We are going to do the same benchmarks on a PIII if you
think it's due to the cpu.

I don't post the URL of the benchmarks to the list because last time we were
slashdotted ;-) and we aren't convinced they are valueable, but I can send
it to you directly if you are interested.

Regards,

--
ricardo galli

