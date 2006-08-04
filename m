Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWHDH2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWHDH2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbWHDH2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:28:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161089AbWHDH17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:27:59 -0400
Date: Fri, 4 Aug 2006 00:24:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060804002423.13a37eae.akpm@osdl.org>
In-Reply-To: <20060804071009.GA15141@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060804062036.GA28137@in.ibm.com>
	<20060803234537.e9b6736d.akpm@osdl.org>
	<20060804071009.GA15141@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 12:40:09 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> > So my take was "looks good, done deal - let's go get some sane controllers
> > working".  And now this!
> 
> My recollection from the BoF is that people felt interface wasn't a major
> issue and it wasn't discussed much. Most of the discussion centered
> around grouping of tasks and the mem/cpu controllers and some additional
> resource control requirements from openvz folks.

OK.  That's certainly the area to be concentrating on.

> One way to go forward with the interface could be to request Chandra
> to repost the ckrm infrastructure and see if the stake holders (primarily
> container folks) can review and agree on it.

Fine.  But let's separate that activity from the primary one: worrying
about the controllers.
