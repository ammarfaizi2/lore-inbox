Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262270AbSJGA0u>; Sun, 6 Oct 2002 20:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbSJGA0u>; Sun, 6 Oct 2002 20:26:50 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:3478 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262270AbSJGA0t>; Sun, 6 Oct 2002 20:26:49 -0400
Date: Sun, 6 Oct 2002 20:35:41 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: benchmarks 2.5.40-mm1 and 2.5.39 on quad xeon
Message-ID: <20021007003541.GA17916@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fork improvements continue in the 2.5 tree.

Seconds to build autoconf-2.53 12 times:
		seconds
2.5.39          780.3
2.5.40-mm1      750.5  4% faster

ext[23] filesystems built with e2fsprogs-1.29.

postgres database create times 4-8% faster.

kernel - ext3   Create-ui   Create   Create-emb
2.5.39          326.4       311.7    333.7     seconds
2.5.40-mm1      300.9       299.2    318.9     

dbench 64 on ext2 13% faster.   

dbench 64	  avg 5 runs
2.5.39            201.40 mb/sec
2.5.40-mm1        227.55 

dbench 192       avg 5 runs
2.5.39           189.57 mb/sec
2.5.40-mm1       193.55

tbench 192 11% faster.

tbench 192
2.5.39           118.17
2.5.40-mm1       131.39

In the 120% memory pressure test there has been
a 66% improvement since 2.5.38:

qsbench    h:mm:ss   
2.5.38     1:57:48
2.5.39     1:30:49
2.5.40-mm1 1:10:40

All tests on quad xeon with 3.75 gb ram.
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

