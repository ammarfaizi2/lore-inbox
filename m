Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUJaXde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUJaXde (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUJaXde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:33:34 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:27782 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261692AbUJaXdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:33:33 -0500
Date: Mon, 1 Nov 2004 00:33:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
Message-ID: <20041031233313.GB6909@elf.ucw.cz>
References: <4183A602.7090403@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4183A602.7090403@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This code was designed to touch the least number of files, be completely
> arch-independant, and allow extra schedulers to be coded in by only
> touching Kconfig, scheduler.c and scheduler.h. It should incur no
> overhead when run and will allow you to compile in only the scheduler(s)
> you desire. This allows, for example, embedded hardware to have a tiny
> new scheduler that takes up minimal code space.

You are changing 

some_functions()

into

something->function()

no? I do not think that is 0 overhead...
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
