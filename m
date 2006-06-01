Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWFAKKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWFAKKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWFAKKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:10:04 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:37892 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S964906AbWFAKKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:10:03 -0400
Message-ID: <447EBCF9.8090208@onelan.co.uk>
Date: Thu, 01 Jun 2006 11:10:01 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not working
 on 2.6.16
References: <4469E709.7080501@onelan.co.uk>	<20060522035943.7829ee32.akpm@osdl.org>	<447EB970.8030005@onelan.co.uk> <20060601030615.41b70b1f.akpm@osdl.org>
In-Reply-To: <20060601030615.41b70b1f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 01 Jun 2006 10:54:56 +0100
> Barry Scott <barry.scott@onelan.co.uk> wrote:
>
>   
...
>> I'm willing to help get this fixed. I'm happy working inside kernels and 
>> drivers
>> but will need some guidance to know where to focus to track this down.
>>     
>
> ACPI, most likely.
>
>   
>> The obvious problem is solve is why are no interrupts being received by
>> the tg3.c code.
>>
>> Which kernel should I use to debug this? 2.6.17 latest RC?
>> Which debug options do you suggest I turn on to get closer to the problem?
>> What information should I collect?
>>     
>
> A git-bisect search would be a suitable way of finding out where it broke.
>
> But then, we don't know if this machine has _ever_ worked with IO-APIC's
> enabled, do we?
>   
 From the point of view of APIC its not a regression. Isn't the way 
forward to find out
why it does not work now as there is no old code that did work to 
compare to?

Barry

