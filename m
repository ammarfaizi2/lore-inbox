Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUBWDIG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUBWDIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:08:06 -0500
Received: from eth13.com-link.com ([208.242.241.164]:43149 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id S261191AbUBWDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:08:02 -0500
Message-ID: <40396E8F.4050307@realitydiluted.com>
Date: Sun, 22 Feb 2004 22:07:59 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM...
References: <40396134.6030906@realitydiluted.com> <20040222190047.01f6f024.akpm@osdl.org>
In-Reply-To: <20040222190047.01f6f024.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
>>+config BLK_DEV_SR_PARTITIONS
>>+config BLK_DEV_SR_PARTITIONS_PER_DEVICE
> 
> 
> Do we actually need these config options?  Why not hardwire it to some
> reasonable upper bound and be done with it?
>
I have no problem hardwiring the number of partitions, but the
BLK_DEV_SR_PARTITIONS should still be an option to allow the
user to decided if they want partitioning support for their
SCSI CDROMs. Or are you suggesting that from now on partitions
will be supported by default?

> Why is this ifdef needed?
> 
Indeed, it is pointless.

-Steve
