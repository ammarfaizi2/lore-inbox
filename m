Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUCCNm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 08:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUCCNm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 08:42:29 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11910 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261791AbUCCNm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 08:42:27 -0500
Message-ID: <4045E0C1.9020806@namesys.com>
Date: Wed, 03 Mar 2004 16:42:25 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       David Weinehall <david@southpole.se>,
       Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu> <200403030700.57164.robin.rosenberg.lists@dewire.com> <1078307033.904.1.camel@teapot.felipe-alfaro.com> <200403031059.26483.robin.rosenberg.lists@dewire.com>
In-Reply-To: <200403031059.26483.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:

>On Wednesday 03 March 2004 10:43, Felipe Alfaro Solana wrote:
>  
>
>>But XFS easily breaks down due to media defects. Once ago I used XFS,
>>but I lost all data on one of my volumes due to a bad block on my hard
>>disk. XFS was unable to recover from the error, and the XFS recovery
>>tools were unable to deal with the error.
>>    
>>
>
>What file systems work on defect media? 
>
>As for crashed disks I rarely bothered trying to "fix" them anymore. I save
>what I can and restore what's backed up and recovery tools (other than
>the undo-delete ones) usually destroy what's left, but that's not unique to
>XFS. Depending on how good my backups are I sometimes try the recovery
>tools just to see, but that has never helped so far.
>
>-- robin
>
>
>  
>
Never attempt to recover without first dd_rescue ing to a good hard 
drive, and doing the recovery there on good hard drive.

-- 
Hans


