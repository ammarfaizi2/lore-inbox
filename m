Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTHYFPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 01:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTHYFPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 01:15:35 -0400
Received: from dp.samba.org ([66.70.73.150]:18912 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261449AbTHYFPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 01:15:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2 
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paulmck@us.ibm.com
In-reply-to: Your message of "Mon, 18 Aug 2003 16:16:06 +0200."
             <20030818141606.GU7862@dualathlon.random> 
Date: Mon, 25 Aug 2003 13:35:03 +1000
Message-Id: <20030825051534.2A4762C37A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030818141606.GU7862@dualathlon.random> you write:
> Hi,
> 
> On Fri, Aug 08, 2003 at 12:21:04PM +1000, Rusty Russell wrote:
> > It is the latter that I am concerned about changing mid-stable-series.
> 
> given the number of users (a dozen) I wouldn't be concerned about the
> API change either.

Hi Andrea,

	We don't know how many there are *outside* the tree during the
stable series, though.  It's really nice if APIs don't change
gratuitously during stable kernels, because there are lots of (free,
source available) patches which are outside the tree, and that's a
*good* thing, IMHO.

Change it now or leave it, IMHO.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
