Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbSLNJNt>; Sat, 14 Dec 2002 04:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbSLNJNt>; Sat, 14 Dec 2002 04:13:49 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:65225
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267507AbSLNJNs>; Sat, 14 Dec 2002 04:13:48 -0500
Message-ID: <3DFAF9EF.6000501@tupshin.com>
Date: Sat, 14 Dec 2002 01:29:19 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: JDIRTY JWAIT errors in 2.4.19
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm getting the following error logged every 11 seconds or so:

Dec 14 01:00:49 phylum kernel: vs-3050: wait_buffer_until_released: nobody
releases buffer (dev 16:01, size 4096, blocknr 2916352, count 3, list 0, 
state
0x10019, page c1172108, (UPTODATE, CLEAN, UNLOCKED)). Still waiting
(-1320000000) JDIRTY !JWAIT

Also, some processes are blocking, include ps (so I can't get a complete 
process list), and shutdown.

This is on an old PII that's been up with no problems for about a month.
Is this a known problem? Is there any way to force a clean shutdown in 
such circumstances? Is this associated with reiserfs which all 
partitions are running? A googling turned up one or two references to 
this problem, but never with a kernel as recent as 2.4.19, and 
associated with, though not necessarily blamed on reiserfs.

This machine is still up, so if more info would be useful, it can 
probably be provided. Most processes are still working fine.

-Tupshin

