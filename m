Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWGUVOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWGUVOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGUVOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:14:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53721 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751183AbWGUVOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:14:19 -0400
Message-ID: <44C1439C.20905@garzik.org>
Date: Fri, 21 Jul 2006 17:14:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153445087.44c02cdf40511@portal.student.luth.se> <Pine.LNX.4.61.0607211623270.28469@yvahk01.tjqt.qr> <200607212027.37823.mb@bu3sch.de>
In-Reply-To: <200607212027.37823.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Friday 21 July 2006 16:23, Jan Engelhardt wrote:
>>> The changes are:
>>> * u2 has been corrected to u1 (and also added it as __u1)
>> Do we really need this? Is not 'bool' enough?
> 
> I would say we don't even _want_ this.
> A u1 variable will basically never be one bit wide.
> It will be at least 8bit, or let's say 32bit. Maybe
> even 64bit on some archs. It all depends on the compiler
> plus the arch.
> 
> We _don't_ want u1, because we don't get what we see.

For this and 1000 other reasons, we don't want u1.

	Jeff



