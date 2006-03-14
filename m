Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWCNMjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWCNMjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWCNMjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:39:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:56778 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751895AbWCNMjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:39:23 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200603142329.31281.kernel@kolivas.org>
References: <1142329861.9710.16.camel@homer>
	 <200603142307.01682.kernel@kolivas.org> <1142339099.11303.12.camel@homer>
	 <200603142329.31281.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 13:40:34 +0100
Message-Id: <1142340034.11303.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 23:29 +1100, Con Kolivas wrote:
> On Tuesday 14 March 2006 23:24, Mike Galbraith wrote:
> >
> > Don't forget, every one of the exploits I test with were posted by
> > people who were experiencing scheduler problems in real life.  Try to
> > use your box while running those exploits, and then tell me that you
> > agree with interbench's assessment.
> 
> Ok you feel interbench is an irrelevant benchmark for your test case and I'm 
> not going to bother arguing since it doesn't claim to test every single 
> situation.

Yes.  Interbench's opinion is irrelevant to me wrt this problem.

> That doesn't change the fact that your patch has only been tested by yourself. 
> Don't forget I'm still agreeing with your change, I'm just suggesting the 
> usual patch precautions.

Sure.  Let's get people interested in testing this ASAP.  OTOH, let's
not delay this simple and (IMHO) dead obvious fix getting into 2.6.16
simply because I'm the only one who _has_ done massive amounts of
testing ;-)

	-Mike

