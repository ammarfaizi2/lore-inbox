Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUF2XUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUF2XUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUF2XUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:20:53 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:62982 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266138AbUF2XUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:20:43 -0400
Message-ID: <40E1FE21.7090905@techsource.com>
Date: Tue, 29 Jun 2004 19:41:21 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Markus Schaber <schabios@logi-track.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block Device Caching
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com> <20040629224622.GQ15166@schnapps.adilger.int>
In-Reply-To: <20040629224622.GQ15166@schnapps.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andreas Dilger wrote:

> 
> 
> When you close the block device it flushes the cache for that device (inode).
> If you kept the device open in some way (e.g. "sleep 10000000 < /dev/hda5")
> then it should start caching the data between dd runs.
> 


Ok, now THIS makes sense.

