Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTLIATX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTLIATX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:19:23 -0500
Received: from dp.samba.org ([66.70.73.150]:28064 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262092AbTLIATR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:19:17 -0500
Date: Tue, 9 Dec 2003 11:14:12 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zwane Mwaikambo <zwane@zwane.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Message-ID: <20031209001412.GG19412@krispykreme>
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD50456.3050003@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't have an architecture independant way to build SMT scheduling
> descriptions, although with the cpu_sibling_map change, you can copy
> and paste the code for the P4 if you are able to build a cpu_sibling_map.

I can build a suitable table, I did that for Ingos HT scheduler.

> I'll just have to add a some bits so SMT and NUMA work together which
> I will be unable to test. I'll get back to you with some code.

Thanks.

Anton
