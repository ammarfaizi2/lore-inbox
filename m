Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUBZELu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUBZELu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:11:50 -0500
Received: from alt.aurema.com ([203.217.18.57]:12469 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262669AbUBZEK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:10:28 -0500
Message-ID: <403D71AB.9060609@aurema.com>
Date: Thu, 26 Feb 2004 15:10:19 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com>
In-Reply-To: <403D5D32.4010007@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Peter Williams wrote:
> 
>> 2. have a user space daemon poll running tasks periodically and renice 
>> them if they are running specified binaries
>>
>> Both of these solutions have their advantages and disadvantages, are 
>> (obviously) complicated than I've made them sound and would require a 
>> great deal of care to be taken during their implementation.  However, 
>> I think that they are both doable.  My personal preference would be 
>> for the in kernel solution on the grounds of efficiency.
> 
> 
> Better would be to have the kernel tell the daemon whenever a process in 
> exec-ed, and you have simplicity in the kernel, and policy in user space.

Yes.  That would be a good solution.  Does a mechanism that allows the 
kernel to notify specific programs about specific events like this exist?

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


