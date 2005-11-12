Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVKLOWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVKLOWu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVKLOWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:22:50 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55764 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932385AbVKLOWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:22:50 -0500
Date: Sat, 12 Nov 2005 15:23:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rt11 2/3] Switch to using get_cycles() rather than get_cpu_tick()
Message-ID: <20051112142304.GB24163@elte.hu>
References: <20051111204312.11609.23222.sendpatchset@localhost.localdomain> <20051111204322.11609.61829.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111204322.11609.61829.sendpatchset@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> In a few different drivers we had what boiled down to a custom 
> implementation of get_cycles().  On i386 and ppc32 this was the same 
> code, and I assume similar for ARM and MIPS.  In one case 
> (kernel/latency.c) it really was get_cycles() in the !i386 case.  
> Always using get_cycles() makes new platform bringup easier.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

thanks, applied.

	Ingo
