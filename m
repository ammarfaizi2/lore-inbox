Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVH3TUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVH3TUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVH3TUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:20:20 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:43202 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932388AbVH3TUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:20:18 -0400
Date: Tue, 30 Aug 2005 19:18:52 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <200508292310.39903.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.61.0508301909220.25574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <200508292310.39903.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005, Al Boldi wrote:

> Holger Kiehl wrote:
>> Why do I only get 247 MB/s for writting and 227 MB/s for reading (from the
>> bonnie++ results) for a Raid0 over 8 disks? I was expecting to get nearly
>> three times those numbers if you take the numbers from the individual
>> disks.
>>
>> What limit am I hitting here?
>
> You may be hitting a 2.6 kernel bug, which has something to do with
> readahead, ask Jens Axboe about it! (see "[git patches] IDE update" thread)
> Sadly, 2.6.13 did not fix it either.
>
I did read that threat, but due to my limited understanding about kernel
code, don't see the relation to my problem.

But I am willing to try any patches to solve the problem.

> Did you try 2.4.31?
>
No. Will give this a try if the problem is not found.

Thanks,
Holger

