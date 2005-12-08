Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVLHLMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLHLMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVLHLMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 06:12:22 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:33811 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S932065AbVLHLMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 06:12:22 -0500
In-Reply-To: <loom.20051208T113436-719@post.gmane.org>
References: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org> <4397E427.2070702@laposte.net> <6A700AF6-1E1B-49A7-A565-336700882097@oxley.org> <loom.20051208T113436-719@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D828B67B-B432-463A-8DEE-D3B738885CB8@oxley.org>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: Linux Hardware Quality Labs (was: Linux in a binary world... a doomsday scenario)
Date: Thu, 8 Dec 2005 11:12:19 +0000
To: Dirk Steuwer <dirk@steuwer.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Dec 2005, at 10:46, Dirk Steuwer wrote:

>
>> I presume that drivers will be developed alongside the hardware
>> because you can't sell the kit until the drivers are on the CD in the
>> nice box with the instruction manual.
>
> It wil be real "plug and play". The driver is not in the  
> hardwarebox, its in
> the linux/bsd/whatever kernel.
> Ideally, people with the right kernel stick the hardware in and it  
> just works.
> No driver installation involved. This is an important aspect, that  
> currently
> nobody out there links to linux. If you ask someone why they not  
> use linux
> its hardware problems - mostly on desktop/laptop. But any free  
> operation system
> with free drivers should be known for an "instant run" of supported  
> hardware.
> No more driver installation worries is a fantastic side effect of  
> free drivers.
>
>
>> Also you can't test the hardware properly unless you have drivers for
>> it.
>>
>
> The hardware vendor has to provide
> a) documentation of the interface
> b) samples to maybe three kernel developers for review
>
> if three developers certify that it works, the overlooking Org. can  
> release
> the logo to be included on the box.
> If the vendor is not cooperating alongside hardware development,  
> the inital box
> with css drivers will go into market, and only later a linux  
> sticker is added.
>

The documentation aspect could solve this chicken and egg problem.
If the OEM has provided documentation and initail versions of the  
driver under GPL (and we assume that they intend to complete the driver)
then we can give them the logo before the driver is 100% perfect in  
order that they can print their product boxes etc.

However, an OEM with a certified device which has become broken over  
time (or they didn't bother to finalise the driver after they had  
been granted the logo) will not be able to get any further hardware  
certified. They will have to fix the existing stuff first.

regards,
Felix
