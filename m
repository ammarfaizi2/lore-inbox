Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUCDAoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCDAoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:44:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20984 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261358AbUCDAoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:44:02 -0500
Message-ID: <40467BC3.7030708@mvista.com>
Date: Wed, 03 Mar 2004 16:43:47 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, amitkale@emsyssoft.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200402061914.38826.amitkale@emsyssoft.com> <403FDB37.2020704@mvista.com> <200403011508.23626.amitkale@emsyssoft.com> <4044F84D.4030003@mvista.com> <20040302132751.255b9807.akpm@osdl.org> <20040303100515.GB8008@wotan.suse.de>
In-Reply-To: <20040303100515.GB8008@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Mar 02, 2004 at 01:27:51PM -0800, Andrew Morton wrote:
> 
>>George Anzinger <george@mvista.com> wrote:
>>
>>> Often it is not clear just why we are in the stub, given that 
>>>we trap such things as kernel page faults, NMI watchdog, BUG macros and such.
>>
>>Yes, that can be confusing.  A little printk on the console prior to
>>entering the debugger would be nice.
> 
> 
> What I did for kdb and panic some time ago was to flash the keyboard
> lights. If you use a unique frequency (different from kdb 
> and from panic) it works quite nicely.

Assuming a key board and a clear (no spin locks) path to it.  Still it only says 
we are in kgdb, now why.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

