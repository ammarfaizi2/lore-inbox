Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267576AbRGZD3B>; Wed, 25 Jul 2001 23:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267591AbRGZD2u>; Wed, 25 Jul 2001 23:28:50 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:58328 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267576AbRGZD2f>; Wed, 25 Jul 2001 23:28:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
Date: Wed, 25 Jul 2001 23:27:52 -0400
X-Mailer: KMail [version 1.2.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Cc: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [RFC] Optimization for use-once pages
Message-Id: <20010726032753.2C45C1225@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Here are some more figures.  

2.4.7 + ide patch + ide dma timeout fix + lvm beta8 + reiserfs fs

Throughput 19.3959 MB/sec (NB=24.2449 MB/sec  193.959 MBit/sec)
dbench 20  24.88s user 70.89s system 69% cpu 2:17.23 total

Throughput 19.0447 MB/sec (NB=23.8059 MB/sec  190.447 MBit/sec)
dbench 20  24.37s user 69.24s system 67% cpu 2:19.63 total

tob -f - -full misc > misc-0725.tob  235.80s user 321.73s system 42% cpu 21:52.49 total


2.4.7 + ide patch + ide dma timeout fix + lvm beta8 + reiserfs fs

Throughput 19.3395 MB/sec (NB=24.1744 MB/sec  193.395 MBit/sec)
dbench 20  23.70s user 70.68s system 68% cpu 2:17.52 total

Throughput 19.1872 MB/sec (NB=23.9841 MB/sec  191.872 MBit/sec)
dbench 20  24.30s user 69.42s system 67% cpu 2:18.60 total

tob -f - -full misc > /back/misc-0725.tob  229.64s user 326.26s system 43% cpu 21:11.77 total

Basicily no big changes here - which is good news.

Ed Tomlinson
