Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWBAGqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWBAGqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWBAGqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:46:07 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4533 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030555AbWBAGqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:46:05 -0500
Message-ID: <43E05941.20007@t-online.de>
Date: Wed, 01 Feb 2006 07:46:25 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
Subject: Re: [BUG] nfs version 2 broken
References: <43E05031.2000107@t-online.de>	 <1138774519.7861.4.camel@lade.trondhjem.org>  <43E0567F.20004@t-online.de> <1138775744.7875.0.camel@lade.trondhjem.org>
In-Reply-To: <1138775744.7875.0.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: r1X3woZTgeRG4lhHZOzUmd1QTHkmOw-iAipuVfry48qT-RU3uqgfod@t-dialin.net
X-TOI-MSGID: 85c068d8-5bc1-44d3-8f37-142bf2bb2308
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>AOpen i915GMm-HFS with Pentium M, linux kernel 2.6.15-git7
>>running a system that startet as SuSE 9.2. Nfs-utils are still
>>the original 1.0.6, grep -i nfs linuxbuild/.config gives
>>    
>>
>
>...and what kind of filesystem are you exporting?
>
>  
>

linux:/src/k6bv3p # dmesg | grep sda

[4294667.296000] Kernel command line: root=/dev/sda3 
video=intelfb:vram=8 vga=0x307
[   46.848978] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   46.850423] sda: Write Protect is off
[   46.851871] sda: Mode Sense: 00 3a 00 10
[   46.851884] SCSI device sda: drive cache: write back w/ FUA
[   46.853385] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[   46.854868] sda: Write Protect is off
[   46.856330] sda: Mode Sense: 00 3a 00 10
[   46.856342] SCSI device sda: drive cache: write back w/ FUA
[   46.857821]  sda: sda1 sda2 sda3
[   46.869751] sd 0:0:0:0: Attached scsi disk sda
[   20.839566] ReiserFS: sda3: found reiserfs format "3.6" with standard 
journal
[   22.412053] ReiserFS: sda3: using ordered data mode
[   22.417920] ReiserFS: sda3: journal params: device sda3, size 8192, 
journal first block 18, max trans len 1024, max batch900, max commit age 
30, max trans age 30
[   22.419518] ReiserFS: sda3: checking transaction log (sda3)
[   22.440517] ReiserFS: sda3: Using r5 hash to sort names
[   24.597554] Adding 1052216k swap on /dev/sda1.  Priority:42 extents:1 
across:1052216k

(printk timestamp anomalities caused by cpu speed)

cu,
 Knut


cu,
 Knut
