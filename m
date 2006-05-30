Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWE3Bey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWE3Bey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWE3BbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932095AbWE3BaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:30:14 -0400
Date: Mon, 29 May 2006 18:34:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 16/61] lock validator: fown locking workaround
Message-Id: <20060529183404.48878079.akpm@osdl.org>
In-Reply-To: <20060529212423.GP3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212423.GP3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:23 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> temporary workaround for the lock validator: make all uses of
> f_owner.lock irq-safe. (The real solution will be to express to
> the lock validator that f_owner.lock rules are to be generated
> per-filesystem.)

This description forgot to tell us what problem is being worked around.

This patch is a bit of a show-stopper.  How hard-n-bad is the real fix?
