Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbUCAJsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUCAJsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:48:00 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:51928 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261191AbUCAJr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:47:58 -0500
Message-ID: <404306BE.6000803@matchmail.com>
Date: Mon, 01 Mar 2004 01:47:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MM VM patches was: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <4042F38B.8020307@matchmail.com> <4042F7E6.1050904@cyberone.com.au> <4042FCBC.7000809@matchmail.com> <40430204.6040901@cyberone.com.au>
In-Reply-To: <40430204.6040901@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
>> So, I'll merge up 2.6.3 + "vm of rc1-mm1" and tell you guys what I see.
>>
> 
> I'm not so hopeful for you anymore :P

These patches apply with only a few offsets if you apply them like in 
the series file, so there's not much work for either of us in applying 
these patches (unless I need to test without a dependent patch or 
something obvious like that...)

> 
>> Are the graphs helpful at all?
>>
> 
> 
> My eyes! The goggles, they do nothing!
> 

Heh.

> They have a lot of good info but I'm a bit hard pressed working
> out what kernel is running where

Suffice it to say, 2.6.3 is the begining of week9, and 2.6.3-lofft-mm4vm 
is the end of week9.  The graphs weren't meant to keep secondary 
information like kernel version...

> and it's a bit hard working out
> all the shades of blue on my crappy little monitor.

Yeah, I see what you mean.  The code in the lrrd/munin project controls 
what colors come in what order, but I can control what order the info is 
output in...

> But if they were easier to read I reckon they'd be useful ;)

I'd like for that to be true especially since I rewrote the memory 
plugin for munin to graph as much as was exported to userspace from the 
Linux kernel...

Did I miss anything? ;)
