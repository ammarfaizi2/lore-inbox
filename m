Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277230AbRJ0WBv>; Sat, 27 Oct 2001 18:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277231AbRJ0WBl>; Sat, 27 Oct 2001 18:01:41 -0400
Received: from mx2.port.ru ([194.67.57.12]:5383 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S277230AbRJ0WB2>;
	Sat, 27 Oct 2001 18:01:28 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200110272203.f9RM3f719917@vegae.deep.net>
Subject: reiserfs(only?) commits hurts laptops`s ability to spindown the drive
To: linux-kernel@vger.kernel.org
Date: Sun, 28 Oct 2001 02:03:40 +0400 (MSD)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Hm, basically subj, however i can add that it can be that this is
     not only reiserfs does that...

 1  0  0  20836   1152   1348   6444    0    0     0    28  857  1568  5 10 85
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  0  0  20836   1152   1348   6444    0    0     0     0  851  1402 12 21 67
 1  0  0  20836   1152   1348   6444    0    0     0     0  853  1543  4 10 86
 1  0  0  20836   1152   1348   6444    0    0     0     0  860  1541  3 13 84
 1  0  0  20836   1152   1348   6444    0    0     0     0  852  1567  2  9 89
 1  0  0  20836   1152   1348   6444    0    0     0    28  854  1507  5  8 87
 1  0  0  20836   1152   1348   6444    0    0     0     0  854  1460  6 21 72
 0  0  0  20836   1152   1348   6444    0    0     0     0  854  1585  6  9 85
 0  0  0  20836   1152   1348   6444    0    0     0     0  852  1558  5 10 85
 0  0  0  20836   1152   1348   6444    0    0     0    28  858  1592  4 11 85
 0  0  0  20836   1152   1348   6444    0    0     0     0  851  1549  3 11 86
 1  0  0  20836   1152   1348   6444    0    0     0     0  852  1437  6 24 70
 1  0  0  20836   1152   1348   6444    0    0     0     0  869  1501  6 10 83
 1  0  0  20836   1152   1348   6444    0    0     0     0  853  1551  6  8 86
 1  0  0  20836   1152   1348   6444    0    0     0    28  857  1524  5 11 84
 1  0  0  20836   1156   1348   6444    0    0     0     0  926  1582 11 15 74
 1  0  0  20836   1152   1348   6444    0    0     0     0  849  1498  8 11 81
 1  0  0  20836   1152   1348   6444    0    0     0     0  885  1549  3 11 86
 1  0  0  20836   1152   1348   6444    0    0     0     0  851  1525  4  8 88
 1  0  0  20836   1152   1348   6444    0    0     0    28  856  1537  3  9 88

etc etc

NOTE: i`m not lame and nothing is doing the disc io (preventing the flames)
 so it must be the VM, or kreiserfsd...

cheers, Samium Gromoff
