Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWFTGRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWFTGRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWFTGRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:17:17 -0400
Received: from mail.gmx.net ([213.165.64.21]:44196 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965083AbWFTGRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:17:16 -0400
X-Authenticated: #14349625
Subject: Re: [RFC] CPU controllers?
From: Mike Galbraith <efault@gmx.de>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org, mingo@elte.hu,
       pwil3058@bigpond.net.au, sekharan@us.ibm.com, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
In-Reply-To: <4496EB2E.2000106@nortel.com>
References: <20060615134632.GA22033@in.ibm.com>
	 <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com>
	 <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>
	 <4494EE86.7090209@yahoo.com.au>  <20060617234259.dc34a20c.akpm@osdl.org>
	 <1150616176.7985.50.camel@Homer.TheSimpsons.net>
	 <4496EB2E.2000106@nortel.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 08:20:42 +0200
Message-Id: <1150784442.7498.27.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 12:21 -0600, Chris Friesen wrote:
> Mike Galbraith wrote:
> 
> > Scheduling contexts do sound useful.  They're easily defeated though, as
> > evolution mail demonstrates to me every time it's GUI hangs and I see
> > that a nice 19 find is running, eating very little CPU, but effectively
> > DoSing evolution nonetheless (journal).  I wonder how often people who
> > tried to distribute CPU would likewise be stymied by other resources.
> 
> We do a lot with diskless blades.  Basically cpu(s), memory, and network 
> ports.
> 
> For this case, cpu, memory, and network controllers are sufficient. 
> Even just cpu gets you a long way, since mostly we're not IO-intensive 
> and we generally have a pretty good idea of memory consumption.

Sure.  Some conflicts can be avoided with foreknowledge, and those
conflicts that do occur don't necessarily make limits worthless or
unmanageable.  Nonetheless, I can imagine them becoming problematic.

	-Mike

