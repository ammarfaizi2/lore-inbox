Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270967AbTHBAcr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 20:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270978AbTHBAcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 20:32:47 -0400
Received: from dp.samba.org ([66.70.73.150]:15276 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270967AbTHBAcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 20:32:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: dipankar@in.ibm.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2 
In-reply-to: Your message of "Fri, 01 Aug 2003 16:00:36 MST."
             <20030801160036.029e542b.akpm@osdl.org> 
Date: Sat, 02 Aug 2003 10:32:24 +1000
Message-Id: <20030802003246.064132C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030801160036.029e542b.akpm@osdl.org> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > 	Gratuitous change to API during stable series BAD BAD BAD.  If
> > you drop this it stays as is until 2.8.  The extra arg in
> > unneccessary, but breaking it is worse.
> 
> There won't be any out-of-tree users by then.

Not that you will know of, that's the entire point IMHO.

All those people who forward port to 2.6, or who are developing
drivers for the first time, completely outside the "normal" channels.
Just please please please don't break any API in a stable series.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
