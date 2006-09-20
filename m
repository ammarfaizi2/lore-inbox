Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWITSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWITSef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWITSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:34:35 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:41143 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932223AbWITSe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:34:26 -0400
Date: Wed, 20 Sep 2006 14:34:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.18-rt1
In-reply-to: <20060920165846.GA31522@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Message-id: <200609201434.19177.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060920141907.GA30765@elte.hu>
 <200609201250.03750.gene.heskett@verizon.net> <20060920165846.GA31522@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 12:58, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>>   LD      .tmp_vmlinux1
>>
>> kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
>> : undefined reference to `hrtimer_update_timer_prio'
>>
>> make: *** [.tmp_vmlinux1] Error 1
>
>yeah, the !hrt build broke in the last minute, i've uploaded -rt2 with
>the fix.
>
And that one does an Opps during boot & freezes.  The first line says 
something about being unable to handle a dereference of $00000000, and 
goes on from there.  Its about 2 screens full, so I'd have to take a pix 
to get any more really accurate data.

I guess we could say the "can an old fart build it" test failed :)

> Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
