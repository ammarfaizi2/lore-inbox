Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUKRVU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUKRVU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUKRVTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:19:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:10958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261173AbUKRVRQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:17:16 -0500
Date: Thu, 18 Nov 2004 13:16:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin =?ISO-8859-1?B?TU9LUkVKX18=?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: chris@tebibyte.org, marcelo.tosatti@cyclades.com, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-Id: <20041118131655.6782108e.akpm@osdl.org>
In-Reply-To: <419CD8C1.4030506@ribosome.natur.cuni.cz>
References: <20041111112922.GA15948@logos.cnet>
	<4193E056.6070100@tebibyte.org>
	<4194EA45.90800@tebibyte.org>
	<20041113233740.GA4121@x30.random>
	<20041114094417.GC29267@logos.cnet>
	<20041114170339.GB13733@dualathlon.random>
	<20041114202155.GB2764@logos.cnet>
	<419A2B3A.80702@tebibyte.org>
	<419B14F9.7080204@tebibyte.org>
	<20041117012346.5bfdf7bc.akpm@osdl.org>
	<419CD8C1.4030506@ribosome.natur.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
>
>    I'm sorry for the delay. I had to re-invent my old memory tests.
>  I have just compared 2.4.26-gentoo-r9 kernel, plain 2.4.28 and
>  plain 2.6.10-rc2. The last has OOM problems, as it kills unnecessarilly
>  2 xterms "in addition" to the application which caused memory outsourcing.
> 
>     I'm not sure which patches sent to the list last days still make
>  sense to be tested.

Please test
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/broken-out/vmscan-ignore-swap-token-when-in-trouble.patch
against 2.6.10-rc2, or latest -linus.
