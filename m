Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSFHT6J>; Sat, 8 Jun 2002 15:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317442AbSFHT6I>; Sat, 8 Jun 2002 15:58:08 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:35550 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317440AbSFHT6G>; Sat, 8 Jun 2002 15:58:06 -0400
Date: Sat, 8 Jun 2002 15:58:28 -0400
To: linux-kernel@vger.kernel.org
Subject: HIGHIO and CONFIG_2GB boost dbench performance
Message-ID: <20020608195828.GA10366@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HIGHIO and CONFIG_2GB improved dbench throughput on ext2, 
ext3, and reiserfs. I compared 4 2.4.19-pre9-aa2 kernel configs 
on a quad Xeon with 3.75 GB ram.

dbench 192 improved more than dbench 64.
ext3 improved 35-65% with these options. 
ext2 improved 27-35%.
reiserfs improved 17-30%.

dbench summary is at:
http://home.earthlink.net/~rwhron/kernel/123gb.html

For sequential reads, HIGHIO and 2GB tiobench has increased
throughput and lower cpu utilization.  tiobench sequential write 
performance in some cases is lower.

-- 
Randy Hron

