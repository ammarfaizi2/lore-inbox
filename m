Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269902AbRHECZi>; Sat, 4 Aug 2001 22:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269904AbRHECZR>; Sat, 4 Aug 2001 22:25:17 -0400
Received: from pD9504018.dip.t-dialin.net ([217.80.64.24]:41454 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S269902AbRHECZG>; Sat, 4 Aug 2001 22:25:06 -0400
Message-ID: <3B6CAE4E.17850717@pcsystems.de>
Date: Sun, 05 Aug 2001 04:24:14 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ext3/reiserfs: ext3fine, reiser got OOPS!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys!

I 've been using ext3 and reiserfs for somedays with
2.4.7. Using mkreiserfs I recieved some null pointer
problems and recieved a kernel oops.
While ext3 is mounted as fast as ext2, reiserfs
seems is slower.

ext3, 10 GB: ~ 0.5 seconds
reisferfs 10 GB: ~ 3-5 seconds

Generating the journal with tune2fs was
again much faster than mkreiserfs. But I think
this is because reiser creates a new fs, wherefore
mkfs.ext2 did that before.

While running there occured some problems
with reiserfs.

I am wondering that reiserfs first got into the kernel
before ext3!


Nico

