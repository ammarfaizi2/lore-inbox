Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVKLQLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVKLQLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 11:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVKLQLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 11:11:37 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:46838 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932408AbVKLQLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 11:11:37 -0500
Message-ID: <43761406.207@mvista.com>
Date: Sat, 12 Nov 2005 08:10:46 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Felix Oxley <lkml@oxley.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [ANNOUNCE] 2.6.14-rc5-rt5 kgdb update
References: <20051017160536.GA2107@elte.hu> <200510211118.18363.lkml@oxley.org> <200510211126.38200.lkml@oxley.org> <200510230023.41494.lkml@oxley.org> <435D6017.8090001@mvista.com> <20051112153239.GA27824@elte.hu>
In-Reply-To: <20051112153239.GA27824@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>For those using kgdb on the rt kernel, I have just updated the patches at:
>>http://source.mvista.com/~ganzinger/
> 
> 
> i tried your kgdb-ga-rt.patch patch on the -rt tree, and it doesnt seem 
> to work: i get up to the initial breakpoint, but after the 'cont' the 
> target system hangs indefinitely. Does it work for you? Config attached.

Uh, I used it with 2.6.14-rt9 yesterday and it seemed to work.  I will look more on Monday, using 
your config.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
