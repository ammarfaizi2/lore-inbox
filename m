Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWAGAeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWAGAeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWAGAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:34:50 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:33504 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S1030228AbWAGAet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:34:49 -0500
Message-ID: <43BF0E27.6020102@pin.if.uz.zgora.pl>
Date: Sat, 07 Jan 2006 01:41:11 +0100
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.15
References: <43BDA76F.1000906@pin.if.uz.zgora.pl> <9a8748490601051512w72ea0baekd52d991d2984c017@mail.gmail.com> <43BE9FDA.2020300@pin.if.uz.zgora.pl> <43BEDCDB.8010102@tmr.com>
In-Reply-To: <43BEDCDB.8010102@tmr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen napisał(a):
> Jacek Luczak wrote:
> 
>> Jesper Juhl napisał(a):
>>
>>>
>>> Try and reproduce with a non-tainted kernel.
>>>
>>
>> Non-tained kernel works great. There is no oops with that. The real 
>> problem is with ndiswrapper + sk98lin conflict. I will try to find 
>> solution and fix this conflict.
> 
> 
> Are you running 4k stacks? I wouldn't expect ndiswrapper to works at all 
> in that case, but...
> 

No! I'm using 8K stacks.
