Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWDGLAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWDGLAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGLAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:00:51 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:59587 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932432AbWDGLAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:00:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Fri, 7 Apr 2006 21:00:16 +1000
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       pwil3058@bigpond.net.au
References: <1144402690.7857.31.camel@homer> <20060407095247.GA2788@elte.hu> <1144407438.8870.5.camel@homer>
In-Reply-To: <1144407438.8870.5.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072100.17900.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 20:57, Mike Galbraith wrote:
> On Fri, 2006-04-07 at 11:52 +0200, Ingo Molnar wrote:
> > i think we should try Mike's patches after smpnice got ironed out. The
> > extreme-starvation cases should be handled more or less correctly now by
> > the minimal set of changes from Mike that are upstream (knock on wood),
> > the singing-dancing add-ons can probably wait a bit and smpnice clearly
> > has priority.
>
> (I'm still trying to find ways to do less singing and dancing.)
>
> This patch you may notice wasn't against an mm kernel.  I was more or
> less separating this one from the others, because I consider this
> problem to be very severe.  IMHO, this or something like it needs to get
> upstream soon.

Which is a fine observation but your code is changing every 2nd day. Which is 
also fine because code needs to evolve. However that's not really the way we 
push stuff upstream...

-ck
