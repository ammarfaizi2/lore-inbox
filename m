Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUCCBbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 20:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbUCCBbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 20:31:20 -0500
Received: from CPE006097a16e12-CM400026313227.cpe.net.cable.rogers.com ([24.101.19.1]:14606
	"EHLO visualfx.animezone.org") by vger.kernel.org with ESMTP
	id S261689AbUCCBbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 20:31:18 -0500
Message-ID: <40453538.8050103@animezone.org>
Date: Tue, 02 Mar 2004 20:30:32 -0500
From: Andrew Ho <andrewho@animezone.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030509
X-Accept-Language: en-us, en, zh-hk, zh, zh-cn
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Dax Kelson <dax@gurulabs.com>, Peter Nelson <pnelson@andrew.cmu.edu>,
       Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com> <4044B787.7080301@andrew.cmu.edu> <1078266793.8582.24.camel@mentor.gurulabs.com> <20040302224758.GK19111@khan.acc.umu.se>
In-Reply-To: <20040302224758.GK19111@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFS is the best filesystem.


David Weinehall wrote:

>On Tue, Mar 02, 2004 at 03:33:13PM -0700, Dax Kelson wrote:
>  
>
>>On Tue, 2004-03-02 at 09:34, Peter Nelson wrote:
>>    
>>
>>>Hans Reiser wrote:
>>>
>>>I'm confused as to why performing a benchmark out of cache as opposed to 
>>>on disk would hurt performance?
>>>      
>>>
>>My understanding (which could be completely wrong) is that reieserfs v3
>>and v4 are algorithmically more complex than ext2 or ext3. Reiserfs
>>spends more CPU time to make the eventual ondisk operations more
>>efficient/faster.
>>
>>When operating purely or mostly out of ram, the higher CPU utilization
>>of reiserfs hurts performance compared to ext2 and ext3.
>>
>>When your system I/O utilization exceeds cache size and your disks
>>starting getting busy, the CPU time previously invested by reiserfs pays
>>big dividends and provides large performance gains versus more
>>simplistic filesystems.  
>>
>>In other words, the CPU penalty paid by reiserfs v3/v4 is more than made
>>up for by the resultant more efficient disk operations. Reiserfs trades 
>>CPU for disk performance.
>>
>>In a nutshell, if you have more memory than you know what do to with,
>>stick with ext3. If you spend all your time waiting for disk operations
>>to complete, go with reiserfs.
>>    
>>
>
>Or rather, if you have more memory than you know what to do with, use
>ext3.  If you have more CPU power than you know what to do with, use
>ReiserFS[34].
>
>On slower machines, I generally prefer a little slower I/O rather than
>having the entire system sluggish because of higher CPU-usage.
>
>
>Regards: David Weinehall
>  
>


