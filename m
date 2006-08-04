Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWHDGtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWHDGtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWHDGtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:49:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932553AbWHDGtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:49:51 -0400
Date: Thu, 3 Aug 2006 23:49:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: pj@sgi.com, vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060803234918.7ae8d9e1.akpm@osdl.org>
In-Reply-To: <20060804063738.GB28137@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060804062036.GA28137@in.ibm.com>
	<20060803233113.3aa9e8b7.pj@sgi.com>
	<20060804063738.GB28137@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 12:07:38 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> On Thu, Aug 03, 2006 at 11:31:13PM -0700, Paul Jackson wrote:
> > Dipankar wrote:
> > > f-series infrastructure
> > 
> > Do you have a good link to follow for more on this?
> > 
> 
> Here is the link to the last posting of the series by Chandra -
> 
> http://lkml.org/lkml/2006/4/27/378
> 

Right, thanks.  Look at the diffstats there.

This:

init/main.c                  |    2 +
kernel/exit.c                |    2 +
kernel/fork.c                |    2 +
fs/proc/base.c               |   19 +++++++++++++++++++
include/linux/sched.h        |    4 +

is the *entire* impact on existing kernel code.  Sweet.
