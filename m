Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266541AbUFQPtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266541AbUFQPtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUFQPtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:49:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:43534 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266541AbUFQPtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:49:09 -0400
Message-ID: <40D1C18B.1030907@techsource.com>
Date: Thu, 17 Jun 2004 12:06:35 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Ken Ryan <linuxryan@leesburg-geeks.org>
CC: linux-kernel@vger.kernel.org, pla@morecom.no
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40D1B110.7020409@leesburg-geeks.org>
In-Reply-To: <40D1B110.7020409@leesburg-geeks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't Reiser4 do wear-leveling for flash?

Ken Ryan wrote:
>> > > > > Data integrity is much more important for us than speed.
>> > > > > > You might want to consider ReiserFS or one of the others 
>> which were > designed with journaling in mind.  And I hope you're 
>> using RAID1 or RAID5.
>>
>> We are using ext3 on a compact flash disk in an embedded device. So we
>> are not using RAID systems.
> 
> 
> [I'm not subscribed, hopefully this threads]
> 
> Um, is this a new application or have you done this before?
> 
> It's my understanding that very few (or no) CF devices do wear-levelling 
> internally.
> Using a journal, especially a true data journal, seems like *the* way to 
> wear out your
> flash as quickly as possible.
> 
> If you've had success using ext2 in read/write mode on flash/CF in a 
> shipping product,
> I for one would like to know more details!
> 
>         ken
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

