Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTAHFIW>; Wed, 8 Jan 2003 00:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267752AbTAHFIW>; Wed, 8 Jan 2003 00:08:22 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:28156 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267750AbTAHFIV>; Wed, 8 Jan 2003 00:08:21 -0500
Date: Wed, 8 Jan 2003 00:22:12 -0500
To: linux-kernel@vger.kernel.org
Subject: pipe bandwidth 75% higher on 2.2 than recent 2.[45]
Message-ID: <20030108052212.GA6540@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LMbench bw_pipe on uniprocessor K6/2 says pipe
bandwidth is about 75% higher on 2.2.23 than other
recent kernels:

kernel                Pipe Bandwidth MB/sec
------------------  -------
2.2.23               115.62
2.4.20-rmap15b        66.90
2.4.21-pre1           67.07
2.4.21-pre2-jam2      70.23
2.4.21-pre2aa2        67.44
2.5.51-mm2            60.71
2.5.54-mm3            64.86

Some other benchmarks at:
http://home.earthlink.net/~rwhron/kernel/latest.html

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

