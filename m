Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVDNIDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVDNIDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDNIDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:03:34 -0400
Received: from smtp2.ilimburg.nl ([195.35.190.136]:38610 "EHLO
	mailrelay.ilimburg.nl") by vger.kernel.org with ESMTP
	id S261456AbVDNID3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:03:29 -0400
Message-ID: <425E23CC.2010509@tuxproject.info>
Date: Thu, 14 Apr 2005 10:03:24 +0200
From: Iwan Sanders <iwan.sanders@tuxproject.info>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Kernel messages
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone explain to me what just happend? I would really like to know 
  :-)
I think that the machine ran out of memory and the OOM killer shot some 
processes, this is what I found
in my logfiles:

1 Time(s): Active:48588 inactive:152 dirty:0 writeback:7 unstable:0 free:502 slab:13664 mapped:48620 pagetables:325
1 Time(s): DMA free:1008kB min:28kB low:56kB high:84kB active:7364kB inactive:0kB present:16384kB
1 Time(s): DMA per-cpu:
1 Time(s): DMA: 0*4kB 0*8kB 1*16kB 7*32kB 4*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1008kB
1 Time(s): Free pages:        2008kB (0kB HighMem)
1 Time(s): HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
1 Time(s): HighMem per-cpu: empty
1 Time(s): HighMem: empty
1 Time(s): Normal free:1000kB min:476kB low:952kB high:1428kB active:186988kB inactive:608kB present:245120kB
1 Time(s): Normal per-cpu:
1 Time(s): Normal: 14*4kB 2*8kB 0*16kB 1*32kB 2*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1000kB
1 Time(s): Swap cache: add 0, delete 0, find 0/0, race 0+0
1 Time(s): cpu 0 cold: low 0, high 2, batch 1
1 Time(s): cpu 0 cold: low 0, high 28, batch 14
1 Time(s): cpu 0 hot: low 2, high 6, batch 1
1 Time(s): cpu 0 hot: low 28, high 84, batch 14
1 Time(s): oom-killer: gfp_mask=0x1d2
1 Time(s): protections[]: 0 0 0
1 Time(s): protections[]: 0 238 238
1 Time(s): protections[]: 14 252 252

Cheers,

Iwan Sanders



