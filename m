Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVE0WbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVE0WbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVE0WbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:31:14 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:15141 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262615AbVE0WbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:31:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=V+6+3Cej8ygmP8KpQQ+KOxETGhyLl3GZxUpLjfUHN2IqZQzpBklDwUxeW011EqOe4M7EiClE82DbA0GIICNbac9ysINnjHEP70x4QD50nSH8NimAwOorDmu+7BWC6C3nB4cvO+vwUR1oQt4bz9YM0aGavfvS86AE3RK8mBjD0Yk=
Message-ID: <42979FA3.1010106@gmail.com>
Date: Sat, 28 May 2005 00:30:59 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com>
In-Reply-To: <42979C4F.8020007@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Michael Thonke wrote:
>
>> Hello Jens,
>>
>> I tried to play with your patch on ICH6R and ICH7R chipset also on
>> Sil3124R Controller
>> with 2xSamsung HD160JJ SATAII drives. But the performance gain stay
>> out..
>> anything special to set to get it working? I used a vanilla-kernel
>> 2.6.12-rc5-git2 for it.
>
>
> SiI 3124 driver needs to be updated to support NCQ.
>
>     Jeff
>
>
>
>
Hello Jeff,

thanks for the info, and whats about Intel ICH6R and ICH7R anything
special there?
I played a bit with the patch and tried to tune it a bit. But there is
no Documentation
for AHCI in kernel.with parameter I can handover or can be changed.
Maybe I've missed them?
If so can you please refer me to one?

Thanks in advance and for help

Greets
     Michael
