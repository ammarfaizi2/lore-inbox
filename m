Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUGLRtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUGLRtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUGLRtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:49:17 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:28407 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265249AbUGLRr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:47:26 -0400
Message-ID: <40F2CF5E.8040806@am.sony.com>
Date: Mon, 12 Jul 2004 10:50:22 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Adam Kropelin <akropel1@rochester.rr.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com>	<20040710115413.A31260@mail.kroptech.com>	<20040710142800.A5093@mail.kroptech.com>	<200407101319.31147.dtor_core@ameritech.net>	<099101c466ba$7d75aa30$03c8a8c0@kroptech.com> <20040710182527.47534358.akpm@osdl.org>
In-Reply-To: <20040710182527.47534358.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Adam Kropelin" <akropel1@rochester.rr.com> wrote:
> 
>>>Does 250 ms worth all this pain?

My requirement is to get to user space in 500 ms from product
cold start.  It would be very nice to do so in 250 ms, to give
user space init more time.  This requirement is pretty
characteristic of many CE products.

>>
>> On a desktop box, almost certainly not. On a massive SMP machine, maybe. On
>> an embedded system that is required to boot in a ridiculously short time,
>> absolutely.
> 
> Yes, it's pretty small beer, but we do recognise that although the number
> of development teams which use features like this is small, the number of
> systems is large, so the features are correspondingly more important.
> 
> One of the services which we kernel developers provide the downstream
> kernel users is the hosting and maintenance of their code so they don't
> have to carry important stuff off-stream, and when the changes are this
> small and simple, I don't see a problem with merging them, even if none of
> "us" will use the feature.

Thanks.  Even if our features aren't mainstream, if we can make them
unintrusive, it's nice to get them integrated.  The help offered here,
to make this as unintrusive and danger-free as possible, is really
appreciated.

As to the number of developers and systems using this, I would wager
that developers at almost every CE company will use this (with developers
in the 100s), and that it will affect (at least) 100s of thousands of
devices (possibly millions, depending on how Linux does in cell phones).

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
