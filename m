Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTELDsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTELDsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:48:19 -0400
Received: from dp.samba.org ([66.70.73.150]:7405 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261866AbTELDsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:48:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bump module ref during init. 
In-reply-to: Your message of "Fri, 09 May 2003 01:54:12 MST."
             <20030509015412.29237b08.akpm@digeo.com> 
Date: Mon, 12 May 2003 10:44:44 +1000
Message-Id: <20030512040100.8FAE92C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030509015412.29237b08.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > +static void wait_for_zero_refcount(struct module *mod)

> What wakes the task up again?

module_put(), as before.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
