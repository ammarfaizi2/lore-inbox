Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbSJDPKH>; Fri, 4 Oct 2002 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261980AbSJDPKA>; Fri, 4 Oct 2002 11:10:00 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63759
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261975AbSJDPJY>; Fri, 4 Oct 2002 11:09:24 -0400
Subject: Re: O(1) Scheduler from Ingo vs. O(1) Scheduler from Robert
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210041716330.3477-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210041716330.3477-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 11:15:09 -0400
Message-Id: <1033744512.909.73.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 11:17, Ingo Molnar wrote:

> On Fri, 4 Oct 2002, Marc-Christian Petersen wrote:
> 
> > say, can anyone explain me why $subject patches are so different? What
> > exactly are the important differences, what patch should we use?
> 
> well as far as i can tell Robert has put other stuff into his patch, which
> isnt really part of the O(1) scheduler. So i'd call it "the O(1) scheduler
> plus stuff".

There should _not_ be other things in the patch aside from the
scheduler.  Those patches are based on Ingo's original 2.4 patches with
back-ported fixes from 2.4-ac and 2.5.  Unfortunately, at the moment the
patch is a bit out of sync.  The only 2.4 version of the scheduler I
have been able to keep up-to-date is 2.4-ac... but the patch is not too
bad.

I think the reason my patches differ from Ingo's is that Ingo includes
code that is not yet in mainline 2.5.  For example, last I checked his
patches had the SCHED_BATCH stuff, which is good, but I only want to put
code that is in 2.5 already and tested.

	Robert Love

