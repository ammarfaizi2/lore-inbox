Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRARTIB>; Thu, 18 Jan 2001 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130241AbRARTHv>; Thu, 18 Jan 2001 14:07:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30726 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129933AbRARTHf>; Thu, 18 Jan 2001 14:07:35 -0500
Date: Thu, 18 Jan 2001 15:17:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.1pre8 slowdown on dbench tests 
Message-ID: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

On my dbench runs I've noted a slowdown between pre4 and pre8 with 48
threads. (128MB, 2 CPU's machine)

pre4: 
Throughput 7.05841 MB/sec (NB=8.82301 MB/sec 70.5841 MBit/sec)
70.94user 232.54system 15:17.39elapsed 33%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+0outputs (1277major+1586minor)pagefaults 0swaps

pre8: 
Throughput 6.11383 MB/sec (NB=7.64229 MB/sec 61.1383 MBit/sec)
70.67user 184.18system 17:38.98elapsed 24%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+0outputs (1277major+1586minor)pagefaults 0swaps


There have been no VM changes between pre4 and pre8. 

Jens, can be the -blk patch the reason for the slowdown I'm seeing?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
