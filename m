Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319026AbSHFJPP>; Tue, 6 Aug 2002 05:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319027AbSHFJPP>; Tue, 6 Aug 2002 05:15:15 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:56295 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319026AbSHFJPM>;
	Tue, 6 Aug 2002 05:15:12 -0400
Message-ID: <3D4F942D.7020100@colorfullife.com>
Date: Tue, 06 Aug 2002 11:17:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		printk("No.\n");
> +		printk("No (that's security hole).\n");
>  #ifdef CONFIG_X86_WP_WORKS_OK

Could you explain the hole?
WP works for user space apps, only ring0 (or ring 0-2?) code ignores the WP bit on i386.

--
	Manfred


