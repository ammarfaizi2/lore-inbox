Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTEEQuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTEEQsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:48:31 -0400
Received: from mail.gmx.net ([213.165.65.60]:51453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263754AbTEEQr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:47:27 -0400
Message-ID: <3EB69883.8090609@gmx.net>
Date: Mon, 05 May 2003 18:59:47 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ezra Nugroho <ezran@goshen.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
References: <1052153060.29588.196.camel@ezran.goshen.edu> 	<3EB693B1.9020505@gmx.net> <1052153834.29676.219.camel@ezran.goshen.edu>
In-Reply-To: <1052153834.29676.219.camel@ezran.goshen.edu>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ezra Nugroho wrote:
> On Mon, 2003-05-05 at 11:39, Carl-Daniel Hailfinger wrote:
> 
>>Ezra Nugroho wrote:
>>
>>>however, I couldn't create any file system for them, or mount them.
>>>/dev/md0px just don't exist.
>>>
>>
>>Please reboot after partitioning.
> 
> I did. Nothing changed. fdisk reported the changes still.

OK. Maybe I wasn't clear enough.
1. Partition a drive
2. Reboot
3. Now the kernel should see the partitions and let you create file
systems on them.

You rebooted and fdisk sees the partitions now. Fine. Please try to
mke2fs /dev/md0p1
That should work. If it doesn't, devfs could be the problem.

Could you please tell us which kernel version you're using?

Carl-Daniel

