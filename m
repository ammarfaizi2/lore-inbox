Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755171AbWKMPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbWKMPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbWKMPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:54:25 -0500
Received: from ref.nmedia.net ([66.39.177.2]:20829 "EHLO ref.nmedia.net")
	by vger.kernel.org with ESMTP id S1755171AbWKMPyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:54:24 -0500
Date: Mon, 13 Nov 2006 07:54:23 -0800 (PST)
From: Shaun Q <shaun@c-think.com>
X-X-Sender: shaun@ref.nmedia.net
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
In-Reply-To: <9a8748490611130600m3b63349eu53b437da5c75a775@mail.gmail.com>
Message-ID: <Pine.BSO.4.64.0611130753010.21533@ref.nmedia.net>
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
 <9a8748490611130600m3b63349eu53b437da5c75a775@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Nov 2006, Jesper Juhl wrote:

> On 13/11/06, Shaun Q <shaun@c-think.com> wrote:
>> Hi there everyone --
>> 
>> I'm trying to build a custom kernel for using both cores of my new
>> Core2Duo E6600 processor...
>> 
>> I thought this was simply a matter of enabling the SMP support in the
>> kernel .config and recompiling, but when the kernel comes back up, still
>> only one core is detected.
>> 
>> With the default vanilla text-based SuSE 10.1 install, it does find both
>> cores...
>> 
>> Anyone have any pointers for me on what I might be missing?
>> 
>
> This is probably not your problem, but it could be, so worth checking.
> Are you booting with  maxcpus=1  on your kernel commandline?
>
If only that were it :)  Unfortunately, no...

> Another thing could be that you need to set CONFIG_NR_CPUS to
> something more than 2. at least in the past some people observed that
> depending on hov CPUs/cores got numbered CONFIG_NR_CPUS needed to be
> set at least as high as the highest numbered core. Try setting it to 8
> and see if that makes a difference.
Yup, mine is set to 8 right now.>
> On a related note; you probably also want to enable CONFIG_SCHED_MC in
> addition to just SMP support.
>
Already set.
> -- 
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
>
Thanks for your help :)
Shaun
