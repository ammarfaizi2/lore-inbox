Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbUKQK1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbUKQK1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbUKQK07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:26:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:1472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262042AbUKQK0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:26:42 -0500
Date: Wed, 17 Nov 2004 02:26:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: chris@tebibyte.org, andrea@novell.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-Id: <20041117022622.04e0e7d7.akpm@osdl.org>
In-Reply-To: <20041117060852.GB19107@logos.cnet>
References: <4193E056.6070100@tebibyte.org>
	<4194EA45.90800@tebibyte.org>
	<20041113233740.GA4121@x30.random>
	<20041114094417.GC29267@logos.cnet>
	<20041114170339.GB13733@dualathlon.random>
	<20041114202155.GB2764@logos.cnet>
	<419A2B3A.80702@tebibyte.org>
	<419B14F9.7080204@tebibyte.org>
	<20041117012346.5bfdf7bc.akpm@osdl.org>
	<20041117060648.GA19107@logos.cnet>
	<20041117060852.GB19107@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Before the swap token patches went in you remember spurious OOM reports  
>  or things were working fine then?

Hard to say, really.  Yes, I think the frequency of reports has increased a
bit in the last month or two.  But it's always been a really small number
of people so that may not be statistically significant.

umm,

there was one report in January		(seems to be a kernel memory leak)
One in February				(ditto)
One in June
Two in July (one was with no swap, one with laptop_mode)
A few in August, but mainly due to the CDROM memory leak.
On August 23 the thrashing control was added.
After that, two or three people have been reporting it.

So yes, we do seem to have gone from basically zero reports up to a trickle.
