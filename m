Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWHDFnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWHDFnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWHDFnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030266AbWHDFnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:14 -0400
Date: Thu, 3 Aug 2006 22:42:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060803224253.49068b98.akpm@osdl.org>
In-Reply-To: <20060803223650.423f2e6a.akpm@osdl.org>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 22:36:50 -0700
Andrew Morton <akpm@osdl.org> wrote:

> I thought the most recently posted CKRM core was a fine piece of code.

I mean, subject to more review, testing, input from stakeholders and blah,
I'd be OK with merging the CKRM core fairly aggressively.  With just a
minimal controller suite.  Because it is good to define the infrastructure
and APIs for task grouping and to then let the controllers fall into place.

The downside to such a strategy is that there is a risk that nobody ever
gets around to implementing useful controllers, so it ends up dead code. 
I'd judge that the interest in resource management is such that the risk of
this happening is low.

