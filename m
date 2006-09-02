Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWIBCK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWIBCK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 22:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIBCK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 22:10:29 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:46005 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750832AbWIBCK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 22:10:28 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1
Date: Sat, 02 Sep 2006 12:10:25 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <02phf2dfnnnmtt0d9pgq550g2kdbem1ch6@4ax.com>
References: <20060901015818.42767813.akpm@osdl.org> <3tkhf2p4f1n1s7ancfmclrlijvne8nhoit@4ax.com> <200609012112.18826.dtor@insightbb.com>
In-Reply-To: <200609012112.18826.dtor@insightbb.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 21:12:18 -0400, Dmitry Torokhov <dtor@insightbb.com> wrote:

>On Friday 01 September 2006 21:06, Grant Coady wrote:
>> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
>> 
>> >
>> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
>> ...
>> >- See the `hot-fixes' directory for any important updates to this patchset.
>> >
>> Okay, I applied hotfixes and it crashed on boot, keyboard LEDs flashing:
>> 
>> Repeating message, hand copied:
>> atkbd.c: Spurious ACK in isa0060/serio0. Some program might be trying access 
>> hardware directly.
>> 
>
>Please try booting with i8042.panicblink=0 to see the real oops (important
>data). We should probably disable blinking if X is not active...

Please, yes ;)  I always boot to CLI console, run linux boxen 
mostly headless...

Now it say:
VFS: Cannot open root device "803" or unknown-block(8,3)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS Unable to mount root fs on unknown-block(8,3)
 _

What next?  (CC akpm removed 'cos bounced)

Grant.

-- 
VGER BF report: H 0
