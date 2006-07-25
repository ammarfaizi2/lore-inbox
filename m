Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWGYTEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWGYTEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWGYTEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:04:15 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:20963 "EHLO
	out5.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964802AbWGYTEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:04:14 -0400
X-Sasl-enc: 2MDe/xSsAIJx9GbU4w+kPbFfRqc59oMf4p4MDWVJKH7x 1153854253
Message-ID: <44C66B28.6020103@yahoo.com>
Date: Tue, 25 Jul 2006 14:04:08 -0500
From: Roman Kononov <kononov195-far@yahoo.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Jeff Garzik <jeff@garzik.org>
CC: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se>	 <1153445087.44c02cdf40511@portal.student.luth.se>	 <44C02F35.4000604@garzik.org> <84144f020607210155v628a51c7td93a647314f4ed78@mail.gmail.com> <44C143B9.6000309@garzik.org>
In-Reply-To: <44C143B9.6000309@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2006 16:14, Jeff Garzik wrote:
> Pekka Enberg wrote:
>> On 7/21/06, Jeff Garzik <jeff@garzik.org> wrote:
>>> I would say:
>>>
>>> #undef true
>>> #undef false
>>> enum {
>>>         false   = 0,
>>>         true    = 1
>>> };
>>>
>>> #define false false
>>> #define true true
>>
>> Just curious, why the #defines?
> 
> So they are visible to cpp as well as C.

What can cpp do with them other than #if defined() or #if !defined()?

Roman

