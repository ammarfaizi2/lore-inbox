Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbSLTAHC>; Thu, 19 Dec 2002 19:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbSLTAHC>; Thu, 19 Dec 2002 19:07:02 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48146
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267651AbSLTAHB>; Thu, 19 Dec 2002 19:07:01 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3E025E1A.EA32918A@digeo.com>
References: <200212200850.32886.conman@kolivas.net>
	 <1040337982.2519.45.camel@phantasy>  <3E0253D9.94961FB@digeo.com>
	 <1040341293.2521.71.camel@phantasy>  <3E025E1A.EA32918A@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040343306.2519.85.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 19:15:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 19:02, Andrew Morton wrote:

> What Con said.  When the scheduler makes an inappropriate decision,
> shortening the timeslice minimises its impact.

OK, I tried it.  It does suck.

I wonder why, though, because with the estimator off the scheduler
should not be making "bad" decisions.

> > But that in no way precludes not fixing what we have, because good
> > algorithms should not require tuning for common cases.  Period.
> 
> hm.  Good luck ;)
> 
> This is a situation in which one is prepares to throw away some cycles
> to achieve a desired effect.

Well one option would be no algorithm at all :)

But if you can find good values that make things run nice, then perhaps
we just need to change the defaults.

I think we should merge sched-tune..

	Robert Love

