Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWHJQdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWHJQdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWHJQdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:33:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15337 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161345AbWHJQdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:33:11 -0400
Message-ID: <44DB5FC0.5070405@us.ibm.com>
Date: Thu, 10 Aug 2006 09:33:04 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Forking ext4 filesystem and JBD2
References: <1155172597.3161.72.camel@localhost.localdomain> <44DACB21.9080002@garzik.org>
In-Reply-To: <44DACB21.9080002@garzik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mingming Cao wrote:
> 
>> This series of patch forkes a new filesystem, ext4, from the current
>> ext3 filesystem, as the code base to work on, for the big features such
>> as extents and larger fs(48 bit blk number) support, per our discussion
>> on lkml a few weeks ago. 
> 

> [...]
> 
>> Any comments? Could we add ext4/jbd2 to mm tree for a wider testing?
> 
> 
> ext4 developers should create a git tree with the consensus-accepted 
> patches.
> 
> That way Linus can pull as soon as the merge window opens, Andrew is 
> guaranteed to have the latest in his -mm tree, and users and other 
> kernel hackers can easily follow the development without having to 
> gather scattered patches from lkml.
>

We do maintain a quilt(akpm) style patches on http://ext2.sf.net, the 
latest patches are always at 
http://ext2.sourceforge.net/48bitext3/patches/latest/

We thought about doing git initially, still open for that doing do, if 
it's more preferable by Linus or Andrew. Just thought  it's a lot 
easiler for non git user to pull the patches from a project website.

Thanks, Mingming


