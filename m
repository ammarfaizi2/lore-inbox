Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUBAKUO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUBAKUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:20:14 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:14500 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265255AbUBAKUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:20:10 -0500
Message-ID: <401CD2B6.3040803@cyberone.com.au>
Date: Sun, 01 Feb 2004 21:19:34 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com, mingo@redhat.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
References: <20040131141937.E58852C082@lists.samba.org> <20040201000314.233e05a7.akpm@osdl.org>
In-Reply-To: <20040201000314.233e05a7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>> The actual CPU patch.  It's big, but almost all under
>> CONFIG_HOTPLUG_CPU, or macros which have same effect.
>>
>
>Needs a fixup.
>
>
>
>CPU_MASK_ALL and CPU_MASK_NONE may only be used for initialisers.  It
>doesn't compile if NR_CPUS>4*BITS_PER_LONG.  Fixes to the cpumask
>infrastructure for this remain welcome.
>
>

The kernel/sched.c stuff otherwise looks pretty straightforward
at a quick glance. I can't see any fundamental problem with it.

