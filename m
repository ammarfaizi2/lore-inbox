Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270978AbTHBBvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 21:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270982AbTHBBvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 21:51:41 -0400
Received: from dp.samba.org ([66.70.73.150]:34746 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270978AbTHBBvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 21:51:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2 
Cc: Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com
In-reply-to: Your message of "Fri, 01 Aug 2003 18:19:43 MST."
             <20030802011943.GA1107@kroah.com> 
Date: Sat, 02 Aug 2003 11:49:41 +1000
Message-Id: <20030802015140.6FE9C2C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030802011943.GA1107@kroah.com> you write:
> On Sat, Aug 02, 2003 at 10:32:24AM +1000, Rusty Russell wrote:
> > Just please please please don't break any API in a stable series.
> 
> We reserve the right to break any in-kernel api if it is deemed
> necessary, this is Linux after all :)

Sure.  But it's not neccessary.  The replacement is cleaner and
smaller, sure, but it's not worth changing once 2.6 is out.  In 2.7,
sure.

I'm happy to accept "no" from Andrew, but not happy to accept "we'll
just change the API midway through 2.6".

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
