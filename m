Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUCALhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUCALhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:37:11 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:56002 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261166AbUCALhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:37:06 -0500
Message-ID: <4043205C.7050109@cyberone.com.au>
Date: Mon, 01 Mar 2004 22:37:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] SMT Nice 2.6.4-rc1-mm1
References: <200403011752.56600.kernel@kolivas.org> <200403012225.59538.kernel@kolivas.org>
In-Reply-To: <200403012225.59538.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Mon, 1 Mar 2004 05:52 pm, Con Kolivas wrote:
>
>>This patch provides full per-package priority support for SMT processors
>>(aka pentium4 hyperthreading) when combined with CONFIG_SCHED_SMT.
>>
>
>And here are some benchmarks to demonstrate what happens. 
>P4 3.06Ghz booted with bios HT off as UP (up), SMP with mm1(mm1), SMP with 
>mm1-smtnice(sn)
>
>

Pretty impressive numbers.

How does it go on the desktop when running mprime at nice +19?
How much worse can latencies of the niced tasks become? Any idea?

