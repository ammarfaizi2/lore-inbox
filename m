Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWGEIPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWGEIPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGEIPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:15:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932404AbWGEIPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:15:47 -0400
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
From: Arjan van de Ven <arjan@infradead.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <44AB726B.8070602@bigpond.net.au>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
	 <20060705063550.GA28004@elte.hu>  <44AB726B.8070602@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 10:15:28 +0200
Message-Id: <1152087328.3201.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Of course, a comprehensive (as opposed to RT only) priority inheritance 
> mechanism would make the "safe/unsafe to background" problem go away and 
> make this patch very simple.  Any plans in that direction?

there is a very simple prio inheritance mechanism available already:
just treat "running in kernel mode" as a "go to nice +19" thing, and I
suspect things will suddenly be safe ;)


