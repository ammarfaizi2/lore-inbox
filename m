Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbULMASw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbULMASw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbULMASw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:18:52 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:29836 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262177AbULMASg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:18:36 -0500
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random>
Message-ID: <cone.1102897095.171542.10669.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Date: Mon, 13 Dec 2004 11:18:15 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> On Mon, Dec 13, 2004 at 10:36:19AM +1100, Con Kolivas wrote:
>> The performance benefit, if any, is often lost in noise during 
>> benchmarks and when there, is less than 1%. So I was wondering if you 
>> had some specific advantage in mind for this patch? Is there some 
>> arch-specific advantage? I can certainly envision disadvantages to lower Hz.
> 
> My last number I've here is 1% for kernel compile. We're not talking
> fancy desktop stuff here, we're talking about raw computing servers that
> runs in userspace 99.9% of the time where the 1% loss is going to be
> multiplied dozen or hundred of times. For those HZ=1000 is a pure
> tangible disavantage.
> 
> For desktops 1% of cpu being lost is not an issue of course.

Thanks. I have to admit that the real reason I wrote this email was for this 
discussion to go on record so that desktop users would not get 
inappropriately excited by this change.

Cheers,
Con

