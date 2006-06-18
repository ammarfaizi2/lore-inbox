Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWFRHdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWFRHdg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFRHdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:33:18 -0400
Received: from mail.gmx.de ([213.165.64.21]:56972 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932139AbWFRHcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:32:31 -0400
X-Authenticated: #14349625
Subject: Re: [RFC] CPU controllers?
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net, vatsa@in.ibm.com,
       dev@openvz.org, mingo@elte.hu, pwil3058@bigpond.net.au,
       sekharan@us.ibm.com, balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
In-Reply-To: <20060617234259.dc34a20c.akpm@osdl.org>
References: <20060615134632.GA22033@in.ibm.com>
	 <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com>
	 <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>
	 <4494EE86.7090209@yahoo.com.au>  <20060617234259.dc34a20c.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 09:36:16 +0200
Message-Id: <1150616176.7985.50.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 23:42 -0700, Andrew Morton wrote:
> On Sun, 18 Jun 2006 16:11:18 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Again, I don't care about the solutions at this stage. I want to know
> > what the problem is. Please?
> 
> Isolation.  To prevent one group of processes from damaging the performance
> of other groups, by providing manageability of the resource consumption of
> each group.  There are plenty of applications of this, not just
> server-consolidation-via-server-virtualisation.

Scheduling contexts do sound useful.  They're easily defeated though, as
evolution mail demonstrates to me every time it's GUI hangs and I see
that a nice 19 find is running, eating very little CPU, but effectively
DoSing evolution nonetheless (journal).  I wonder how often people who
tried to distribute CPU would likewise be stymied by other resources.

	-Mike

