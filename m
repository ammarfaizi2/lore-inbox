Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVBCOsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVBCOsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbVBCOj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:39:29 -0500
Received: from alog0321.analogic.com ([208.224.222.97]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263162AbVBCOhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:37:22 -0500
Date: Thu, 3 Feb 2005 09:37:33 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Joe User DOS kills Linux-2.6.10
In-Reply-To: <20050203142943.GB5680@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.61.0502030935480.9196@chaos.analogic.com>
References: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
 <20050203003334.GA5680@pclin040.win.tue.nl> <Pine.LNX.4.61.0502030725480.8811@chaos.analogic.com>
 <20050203142943.GB5680@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Andries Brouwer wrote:

> On Thu, Feb 03, 2005 at 07:28:50AM -0500, linux-os wrote:
>
>> I ran badblocks (all night). There were none. It's a SCSI disk
>> and it requires chunks of DMA RAM for each write. The machine
>> just croaks when it gets low on RAM and tries to write to
>> SCSI swap which requires RAM.
>
> In some other post you said that you were writing past the
> end of the partition or disk.
>
> If the disk is fine and you have reproducible errors
> then the first thing to check is whether your partition table
> is correct, whether your swap signature is correct, whether
> the total size of the disk is recognized correctly at boot time.
>

I just executed `mkswap` on both of my swap partitions. The
original swap partitions were created using very early tools.
I will now try to see if I get the same error, but I can't
do it now because I need a "work-break".


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
