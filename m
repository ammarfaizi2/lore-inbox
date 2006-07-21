Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWGUVOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGUVOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 17:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGUVOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 17:14:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57817 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751191AbWGUVOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 17:14:40 -0400
Message-ID: <44C143B9.6000309@garzik.org>
Date: Fri, 21 Jul 2006 17:14:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se>	 <1153445087.44c02cdf40511@portal.student.luth.se>	 <44C02F35.4000604@garzik.org> <84144f020607210155v628a51c7td93a647314f4ed78@mail.gmail.com>
In-Reply-To: <84144f020607210155v628a51c7td93a647314f4ed78@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 7/21/06, Jeff Garzik <jeff@garzik.org> wrote:
>> I would say:
>>
>> #undef true
>> #undef false
>> enum {
>>         false   = 0,
>>         true    = 1
>> };
>>
>> #define false false
>> #define true true
> 
> Just curious, why the #defines?

So they are visible to cpp as well as C.

	Jeff



