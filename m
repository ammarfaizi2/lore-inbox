Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbUKSANn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUKSANn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUKSALu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:11:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:49388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261202AbUKSAJR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:09:17 -0500
Date: Thu, 18 Nov 2004 16:08:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin =?ISO-8859-1?B?TU9LUkVKX18=?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: piggin@cyberone.com.au, chris@tebibyte.org, marcelo.tosatti@cyclades.com,
       andrea@novell.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-Id: <20041118160824.3bfc961c.akpm@osdl.org>
In-Reply-To: <419D383D.4000901@ribosome.natur.cuni.cz>
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
	<20041118131655.6782108e.akpm@osdl.org>
	<419D25B5.1060504@ribosome.natur.cuni.cz>
	<419D2987.8010305@cyberone.com.au>
	<419D383D.4000901@ribosome.natur.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
>
>   Anyway, plain 2.6.7 kills only the application asking for
>  so much memory and logs via syslog:
>  Out of Memory: Killed process 58888 (RNAsubopt)
> 
>    It's a lot better compared to what we have in 2.6.10-rc2,
>  from my user's view.

We haven't made any changes to the oom-killer algorithm since July 2003. 
Weird.

