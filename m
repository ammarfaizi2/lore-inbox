Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWCUNdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWCUNdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWCUNdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:33:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:2539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751695AbWCUNdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:33:18 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <200603220013.15870.kernel@kolivas.org>
References: <200603090036.49915.kernel@kolivas.org>
	 <200603212253.03637.kernel@kolivas.org> <1142946610.7807.43.camel@homer>
	 <200603220013.15870.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 14:33:20 +0100
Message-Id: <1142948000.7807.63.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 00:13 +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 00:10, Mike Galbraith wrote:
> > How long should Willy be able to scroll without feeling the background,
> > and how long should Apache be able to starve his shell.  They are one
> > and the same, and I can't say, because I'm not Willy.  I don't know how
> > to get there from here without tunables.  Picking defaults is one thing,
> > but I don't know how to make it one-size-fits-all.  For the general
> > case, the values delivered will work fine.  For the apache case, they
> > absolutely 100% guaranteed will not.
> 
> So how do you propose we tune such a beast then? Apache users will use off, 
> everyone else will have no idea but to use the defaults.

Set for desktop, which is intended to mostly emulate what we have right
now, which most people are quite happy with.  The throttle will still
nail most of the corner cases, and the other adjustments nail the
majority of what's left.  That leaves the hefty server type loads as
what certainly will require tuning.  They always need tuning.

	-Mike

