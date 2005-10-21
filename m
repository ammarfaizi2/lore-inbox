Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVJUWEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVJUWEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 18:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVJUWEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 18:04:14 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33720 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965178AbVJUWEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 18:04:14 -0400
Message-ID: <435965D5.8010600@pobox.com>
Date: Fri, 21 Oct 2005 18:04:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Merging ATA passthru
References: <43593E0A.4070801@pobox.com> <43596160.3080407@rtr.ca>
In-Reply-To: <43596160.3080407@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> Folks,
>>
>> Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
>> the ATA passthru work upstream, once 2.6.14 is released.
> 
> 
> Thanks, Jeff!
> 
>> Since there are still some reported problems that I haven't had time 
>> to track down, I'm going to -- like ATAPI -- introduce a module option 
>> that enables passthru.  It will default to off.
> 
> 
> With passthru, it would really be much better to just leave it enabled
> without any option.  It's NOT on any main code path, and users/distros
> have to intentionally run "smartctl -d ata" or "hdparm /dev/sd*" to
> trigger any of it.
> 
> So it is already "off", unless somebody wants to use it.

Not really true, as people constantly try (and fail) to use hdparm with 
their SATA disks today.

Anyway, I have this weird thing about not turning on something by 
default, when I know has it problems ;-)

	Jeff


