Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWCURwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWCURwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWCURwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:52:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:52145 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030297AbWCURwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:52:08 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <200603220220.11368.kernel@kolivas.org>
References: <200603090036.49915.kernel@kolivas.org>
	 <1142949690.7807.80.camel@homer> <200603220117.54822.kernel@kolivas.org>
	 <200603220220.11368.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 18:51:59 +0100
Message-Id: <1142963519.10569.27.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 02:20 +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 01:17, Con Kolivas wrote:
> > I actually believe the same effect can be had by a tiny 
> > modification to enable/disable the estimator anyway.
> 
> Just for argument's sake it would look something like this.

That won't have the same effect.  What you disabled isn't only about
interactivity.   It's also about preemption, throughput and fairness.

	-Mike

(we now interrupt this thread for an evening of real life;)

