Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTEEQ2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbTEEQ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:27:09 -0400
Received: from pop.gmx.net ([213.165.65.60]:61826 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263654AbTEEQ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:26:52 -0400
Message-ID: <3EB693B1.9020505@gmx.net>
Date: Mon, 05 May 2003 18:39:13 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ezra Nugroho <ezran@goshen.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
References: <1052153060.29588.196.camel@ezran.goshen.edu>
In-Reply-To: <1052153060.29588.196.camel@ezran.goshen.edu>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ezra Nugroho wrote:
> I am curious if partitioning meta devices is allowed or not.
> 
> I just created a software raid array, md0 with 240G logical size.
> I want to partition that into two, 100G and the rest.
> 
> I used fdisk to create the partitions, and it worked, result:
> 
> bangalore exports # fdisk /dev/md0
> 
> Command (m for help): p
> 
> Disk /dev/md0: 247.0 GB, 247044636672 bytes
> 2 heads, 4 sectors/track, 60313632 cylinders
> Units = cylinders of 8 * 512 = 4096 bytes
> 
>     Device Boot    Start       End    Blocks   Id  System
> /dev/md0p1             1  24414064  97656254   83  Linux
> /dev/md0p2      24414065  60313632 143598272   83  Linux
> 
> 
> however, I couldn't create any file system for them, or mount them.
> /dev/md0px just don't exist.
> 
> Do I need to partition the drives first before creating the raids?
> I use devfs instead of file based /dev

Please reboot after partitioning.

HTH,
Carl-Daniel

