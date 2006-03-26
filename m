Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWCZQob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWCZQob (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWCZQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:44:31 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9953 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751481AbWCZQoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:44:30 -0500
Date: Sun, 26 Mar 2006 18:41:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 2.6.16-mm1] __mod_timer: simplify ->base changing
Message-ID: <20060326164152.GA23873@elte.hu>
References: <20060326024453.GA9292@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326024453.GA9292@oleg>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> On top of
> 	kill-__init_timer_base-in-favor-of-boot_tvec_bases.patch
> 
> Since base and new_base are of the same type now, we can save one
> 'if' branch and simplify the code a bit.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

nice!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
