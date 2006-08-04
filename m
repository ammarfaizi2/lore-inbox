Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWHDHOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWHDHOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWHDHOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:14:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161075AbWHDHOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:14:10 -0400
Date: Fri, 4 Aug 2006 00:13:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060804001342.1168e5ab.akpm@osdl.org>
In-Reply-To: <20060804065615.GA26960@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060804065615.GA26960@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 12:26:15 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Thu, Aug 03, 2006 at 10:36:50PM -0700, Andrew Morton wrote:
> > ug, I didn't know this.  Had I been there (sorry) I'd have disagreed with
> > this whole strategy.
> > 
> > I thought the most recently posted CKRM core was a fine piece of code.  It
> > provides the machinery for grouping tasks together and the machinery for
> > establishing and viewing those groupings via configfs, and other such
> > common functionality.  My 20-minute impression was that this code was an
> > easy merge and it was just awaiting some useful controllers to come along.
> > 
> > And now we've dumped the good infrastructure and instead we've contentrated
> > on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> > layer.
> 
> Andrew,
> 	CPUset was used in this patch series primarily because it
> represent a task-grouping mechanism already in the kernel and because
> people at the BoF wanted to start with something simple. The idea of using 
> cpusets here was not to push this as a final solution, but use it as a means to 
> discuss the effects of task-grouping on CPU scheduler.

OK.

> We had be more than happy to work with the ckrm core which was posted last.
> In fact I had sent out the same cpu controller against ckrm core itself last
> time around to Nick/Ingo.

Yup.

Please don't let me derail the main intent of this work - to make some progress
on the CPU controller.

There was a lot of discussion last time - Mike, Ingo, others.  It would be
a useful starting point if we could be refreshed on what the main issues
were, and whether/how this new patchset addresses them.

