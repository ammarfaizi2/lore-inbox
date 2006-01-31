Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWAaSjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWAaSjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWAaSjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:39:09 -0500
Received: from [85.8.13.51] ([85.8.13.51]:62179 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751334AbWAaSjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:39:08 -0500
Message-ID: <43DFAEC6.3090205@drzeus.cx>
Date: Tue, 31 Jan 2006 19:39:02 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de> <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx> <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk> <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de>
In-Reply-To: <20060130080930.GB4209@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Jan 30 2006, Pierre Ossman wrote:
>   
>> Jens Axboe wrote:
>>     
>>>
>>> Ah, you need to disable clustering to prevent that from happening! I was
>>> confused there for a while.
>>>
>>>   
>>>       
>> And which is the lesser evil, highmem bounce buffers or disabling
>> clustering? I'd probably vote for the former since the MMC overhead can
>> be quite large.
>>     
>
> Disabling clustering is by far the least expensive way to accomplish it.
>
>   

Russell, what's your view on this? And how should we handle it with
regard to MMC drivers?

Rgds
Pierre

