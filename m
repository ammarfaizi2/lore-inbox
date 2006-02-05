Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWBEWNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWBEWNY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBEWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 17:13:24 -0500
Received: from [198.99.130.12] ([198.99.130.12]:15070 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750757AbWBEWNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 17:13:24 -0500
Date: Sun, 5 Feb 2006 17:13:13 -0500
From: Jeff Dike <jdike@addtoit.com>
To: 7eggert@gmx.de
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Mark Lord <lkml@rtr.ca>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060205221313.GA520@ccure.user-mode-linux.org>
References: <5tvDG-4nl-47@gated-at.bofh.it> <5tvDF-4nl-45@gated-at.bofh.it> <5twTa-6cF-25@gated-at.bofh.it> <5txcv-6OX-31@gated-at.bofh.it> <5ByEo-3fj-7@gated-at.bofh.it> <5BKvR-3gt-25@gated-at.bofh.it> <5BTJ2-fP-3@gated-at.bofh.it> <5ChUM-2f8-21@gated-at.bofh.it> <5CtsV-1zF-3@gated-at.bofh.it> <E1F5qNU-0000kq-FO@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1F5qNU-0000kq-FO@be1.lrz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 09:20:55PM +0100, Bodo Eggert wrote:
> As far as I understand, user mode linux.

Nope, not any more.

UML used to load at the top of the user address space, hence a
dependency on a 3/1 split, but the default config now has UML loading
lower, where other processes load.

				Jeff
