Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUL2OiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUL2OiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUL2OiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:38:11 -0500
Received: from [143.247.20.203] ([143.247.20.203]:23424 "EHLO
	cgx-mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S261330AbUL2OiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:38:07 -0500
Message-ID: <41D2C14C.6090201@capitalgenomix.com>
Date: Wed, 29 Dec 2004 09:38:04 -0500
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Vladimir Saveliev <vs@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem/kernel bug?
References: <41D02F54.8070107@capitalgenomix.com> <41D16500.9070903@capitalgenomix.com> <1104251242.3568.30.camel@tribesman.namesys.com> <41D2A8FC.7080604@capitalgenomix.com> <20041229135510.GQ347@unthought.net>
In-Reply-To: <20041229135510.GQ347@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:

>I've seen this on ext3 and XFS as well.
>
>Both locally (ext3 and XFS) and NFS exported (XFS).
>
>About to try out 2.6.10 with CVS XFS and patches from the list - but
>somehow I doubt that the actual problem is in the filesystems.
>

Part of my reason for panic was that I recently had my Linux router kick 
the bucket.  I also used reiserfs on this system and *believe* it was 
running a 2.6.8 kernel.

The strange thing about this system was that, at first glance, it 
appeared to have a complete hard disk failure.  However, when I rebooted 
the computer, the system did indeed start to boot.  When it came time to 
mount the root file system, it became apparent that it had become 
corrupt.  I've been running Linux systems for years and this was the 
first system that I ever experienced a corrupted file system on.

As a result of my success with file systems on Linux in the past, I've 
been somewhat lazy when partitioning drives lately.  I've been creating 
100 MB boot, system_ram * 2 swap, and throwing everything else in the 
root.  I might have to go back to my old style to separate /, /home and 
/usr onto separate file systems.

-- 
Sean
