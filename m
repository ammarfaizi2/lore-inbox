Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317630AbSFNQaK>; Fri, 14 Jun 2002 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSFNQaJ>; Fri, 14 Jun 2002 12:30:09 -0400
Received: from socp-b.scsnet.com ([146.126.51.51]:42466 "EHLO
	alxapex01.southernco.com") by vger.kernel.org with ESMTP
	id <S317630AbSFNQaI>; Fri, 14 Jun 2002 12:30:08 -0400
Message-ID: <8835B0E4CF43E9498F143219AFEF9F6108F310@GAXGPEX15.southernco.com>
From: "Hron, Randall" <x2hron@southernco.com>
To: "'john.weber@linuxhq.com'" <john.weber@linuxhq.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Date: Fri, 14 Jun 2002 11:29:54 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.33)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (lord knows i'm trying to get up to speed), but, in the meantime, I can
> test the crap out of a kernel :).

tiobench is having trouble completing in kernels >= 2.5.19 on my K6-2
384 mb ram, IDE test system.  The parameters I'm using are:

tiobench.pl --size 2048 --numruns 3 --threads 1 --threads 32 --threads 64
--threads 128

--size depends on ram and disk space.

Early in 2.5, dbench 192 would exercise a bug or two.
(requires about 5GB of disk space)

Linux Test Project's runalltests.sh has occasionally triggered a bug.

2.5 took a drop in dbench throughput recently.

dbench ext2 128 processes       Average         High            Low(MB/sec)
2.5.19                           18.60           21.69           14.58
2.5.20                           12.89           13.15           12.79
2.5.21                           12.67           12.94           12.51

If you want to benchmark some stuff while you're stress testing,
http://home.earthlink.net/~rwhron/kernel/index.html might be a
starting point for ideas.



