Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423484AbWJ0FJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423484AbWJ0FJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423485AbWJ0FJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:09:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:52394 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423484AbWJ0FJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:09:10 -0400
X-Authenticated: #14349625
Subject: Re: [2.6.18-rt7] BUG: time warp detected!
From: Mike Galbraith <efault@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610270007.36648.rjw@sisk.pl>
References: <1161847210.32585.14.camel@Homer.simpson.net>
	 <200610270007.36648.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 05:40:39 +0000
Message-Id: <1161927639.6039.0.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 00:07 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, 26 October 2006 09:20, Mike Galbraith wrote:
> > Greetings,
> > 
> > $subject happened on my single P4/HT box sometime after resume from
> > disk.  Hohum activity:  I had just read lkml and was retrieving latest
> > glibc snapshot when I noticed the trace.  I also noticed that the kernel
> > decided to use pit instead of tsc.
> 
> Please check if CONFIG_PM_TRACE is not set in your .config.

Confirmed, CONFIG_PM_TRACE is not set.

	-Mike

