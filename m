Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTA1Vpd>; Tue, 28 Jan 2003 16:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTA1Vpc>; Tue, 28 Jan 2003 16:45:32 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:4630
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261370AbTA1Vpb>; Tue, 28 Jan 2003 16:45:31 -0500
Message-ID: <3E36FBF7.9080809@rackable.com>
Date: Tue, 28 Jan 2003 13:53:59 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "tester7 A." <benew666@hotmail.com>
CC: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Hangs with SW RAID5 and 2l.4.21-pre3aa1 patch
References: <F85MjT3XOYR00HgHKkR00003b05@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2003 21:54:47.0083 (UTC) FILETIME=[DFB017B0:01C2C717]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tester7 A. wrote:

>
> Motherboard: Intel SDS2
> CPU: P-III 1.4
> RAM: 1024MB
> IDE Controller: 3Ware 7500-8
>
> I am trying to test S/W Raid5 with 2.4.21-pre3aa1 patch
> After making the raidtab and doing 'mkraid' and mount xfs FS on /dev/md1,
> it was keeep showing something about 'buffer size changed from 4096 
> --> 512' and back and forth and hangs.
> After reset, it would not boot due to Raid failure.
>
> After booting with 2.4.20 kernel and remove the raidtab and boot to 
> the 2.4.21-pre3aa1 again and repeat the same, 'mkraid' halts and ps 
> -aux shows raid5d and raid5syncd is in RW and DW, respectively.


  Does a 2.4.21-pre3 kernel work?

>
> Is it known bug in 2.4.21-pre33aa1 kernel?
>
>

  I've seen this as well when I attempted to upgrade a system with 2 
raid0, and 1 raid1 devices.  It was a Intel se7500wv, 4G memory, and two 
3ware  7500-8.  The system works just fine with old aa's, and redhat's 
2.4.18-19 kernel.  I didn't have much time to spend with it, and I was 
waiting to test 2.4.21-pre3 before reporting the bug.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



