Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUAUFSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 00:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUAUFSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 00:18:44 -0500
Received: from dp.samba.org ([66.70.73.150]:59776 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265921AbUAUFSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 00:18:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More cleanups for swsusp 
In-reply-to: Your message of "Tue, 20 Jan 2004 15:13:58 -0800."
             <20040120151358.09608fc3.akpm@osdl.org> 
Date: Wed, 21 Jan 2004 16:10:37 +1100
Message-Id: <20040121051855.A52872C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040120151358.09608fc3.akpm@osdl.org> you write:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > +	BUG_ON (sizeof(struct link) != PAGE_SIZE);
> 
> Looking at the code, this hardly seems worth checking.  But the compiler
> should just rub this code out anwyay, so whatever.
> 
> hmm, one could do:
> 
> #define compile_time_assert(expr)					\

Already there: BUILD_BUG & BUILD_BUG_ON.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
