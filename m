Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269758AbUJMUBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269758AbUJMUBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbUJMUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:01:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269758AbUJMUBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:01:43 -0400
Message-ID: <416D8999.7080102@pobox.com>
Date: Wed, 13 Oct 2004 16:01:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Fitzpatrick <brad@danga.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.9-rc4, dual Opteron, NUMA, 8GB
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
In-Reply-To: <Pine.LNX.4.58.0410131204580.31327@danga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Fitzpatrick wrote:
> I'm reporting an oops.  Details follow.
> 
> I have two of these machines.  I will happily be anybody's guinea pig
> to debug this.  (more details, access to machine, try patches, kernels...)
> Machines aren't in production.
> 
> - Brad
> 
> 
> Kernel:  2.6.9-rc4 vanilla (.config below)
> 
> Hardware:  IBM eServer 325, Dual Opteron 8GB ram (more info below)
> 
> Pre-crash and crash:
> 
> a1:~# mke2fs /dev/mapper/raid10-data
> mke2fs 1.35 (28-Feb-2004)
> Filesystem label=
> OS type: Linux
> Block size=4096 (log=2)
> Fragment size=4096 (log=2)
> 25608192 inodes, 51200000 blocks
> 2560000 blocks (5.00%) reserved for the super user
> First data block=0
> 1563 block groups
> 32768 blocks per group, 32768 fragments per group
> 16384 inodes per group
> Superblock backups stored on blocks:
>         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
>         4096000, 7962624, 11239424, 20480000, 23887872
> 
> Writing inode tables: 1091/1563
> Message from syslogd@localhost at Wed Oct 13 11:46:01 2004 ...
> localhost kernel: Oops: 0000 [1] SMP
> 
> Message from syslogd@localhost at Wed Oct 13 11:46:01 2004 ...
> localhost kernel: CR2: 0000000000001770


What's your block device configuration?  What block devices are sitting 
on top of what other block devices?

	Jeff


