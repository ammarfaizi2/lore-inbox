Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWKGMza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWKGMza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbWKGMza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:55:30 -0500
Received: from il.qumranet.com ([62.219.232.206]:51073 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1753528AbWKGMz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:55:29 -0500
Message-ID: <4550823E.2070108@qumranet.com>
Date: Tue, 07 Nov 2006 14:55:26 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 12/14] KVM: x86 emulator
References: <454E4941.7000108@qumranet.com> <20061105204035.DF0F62500A7@cleopatra.q> <20061107124912.GA23118@elf.ucw.cz>
In-Reply-To: <20061107124912.GA23118@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> Index: linux-2.6/drivers/kvm/x86_emulate.c
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6/drivers/kvm/x86_emulate.c
>> @@ -0,0 +1,1370 @@
>> +/******************************************************************************
>> + * x86_emulate.c
>> + *
>> + * Generic x86 (32-bit and 64-bit) instruction decoder and emulator.
>> + *
>> + * Copyright (c) 2005 Keir Fraser
>> + *
>> + * Linux coding style, mod r/m decoder, segment base fixes, real-mode
>> + * privieged instructions:
>> + *
>> + * Copyright (C) 2006 Qumranet
>> + *
>> + *   Avi Kivity <avi@qumranet.com>
>> + *   Yaniv Kamay <yaniv@qumranet.com>
>> + *
>> + * From: xen-unstable 10676:af9809f51f81a3c43f276f00c81a52ef558afda4
>> + */
>>     
>
> This needs GPL, I'd say.
> 									Pavel
>   

The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so, 
how?  I'd rather not copy the entire license into each file.

Doesn't ../../COPYING cover it, presuming it's accepted?


-- 
error compiling committee.c: too many arguments to function

