Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131882AbRDJTX0>; Tue, 10 Apr 2001 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131886AbRDJTXG>; Tue, 10 Apr 2001 15:23:06 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:22788 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131882AbRDJTXA>; Tue, 10 Apr 2001 15:23:00 -0400
Message-ID: <3AD35DBF.168DD54@t-online.de>
Date: Tue, 10 Apr 2001 21:23:43 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: (ide.2.2.19.04092001.patch:) DiskPerf compile problem
In-Reply-To: <Pine.LNX.4.10.10104091720030.1878-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
...
> DiskPerf /dev/hde
> Device: IBM-DTLA-307075 Serial Number: YSDYSFA5874
> LBA 0 DMA Read Test                      = 63.35 MB/Sec (3.95 Seconds)
> Outer Diameter Sequential DMA Read Test  = 35.89 MB/Sec (6.97 Seconds)
> Inner Diameter Sequential DMA Read Test  = 17.64 MB/Sec (14.17 Seconds)

Where can I get the latest DiskPerf?

The version on:
http://www.xx.kernel.org/pub/linux/kernel/people/hedrick/utility-patches/DiskPerf-1.0.1.tar.gz
does not compile at all:

linux:~/DiskPerf-1.0 # make
gcc -o DiskPerf -O3 -lglib DiskPerf.c
DiskPerf.c: In function `ataRead':
DiskPerf.c:155: storage size of `reqtask' isn't known
DiskPerf.c:156: storage size of `taskfile' isn't known
DiskPerf.c:157: `ide_reg_valid_t' undeclared (first use in this function)
...
