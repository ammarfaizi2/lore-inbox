Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVLEStE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVLEStE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLEStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:49:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:948 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751332AbVLEStB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:49:01 -0500
Date: Mon, 5 Dec 2005 19:49:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.14-rt22 - do_settimeofday() was called!
Message-ID: <20051205184924.GA8960@elte.hu>
References: <5bdc1c8b0512051045k213ef31di5693f166bcfee8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0512051045k213ef31di5693f166bcfee8a4@mail.gmail.com>
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


* Mark Knecht <markknecht@gmail.com> wrote:

> Hi,
>    I just built and booted 2.6.14-rt22. I noticed this message in 
>    dmesg:
> 
> do_settimeofday() was called!
> 
>    I have not followed all the discussions about timers (there have 
> been a lot!) but I do not remember seeing this with either -rt13 or 
> -rt21.
> 
>    Is it normal?

yeah, it's normal - it's just a debugging message.

	Ingo
