Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVDAQGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVDAQGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVDAQGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:06:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:29916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262774AbVDAQGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:06:43 -0500
Date: Fri, 1 Apr 2005 08:08:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
In-Reply-To: <424D373F.1BCBF2AC@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0504010807570.4774@ppc970.osdl.org>
References: <424D373F.1BCBF2AC@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Apr 2005, Oleg Nesterov wrote:
>
> This patch replaces and updates 6 timer patches which are currently
> in -mm tree. This version does not play games with __TIMER_PENDING
> bit, so incremental patch is not suitable. It is against 2.6.12-rc1.
> Please comment. I am sending pseudo code in a separate message for
> easier review.

Looks ok by me. Andrew, should we let it cook in -mm, or what?

		Linus
