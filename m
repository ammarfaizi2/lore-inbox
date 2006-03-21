Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWCUObE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWCUObE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWCUObE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:31:04 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:15847 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751072AbWCUObD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:31:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 01:30:33 +1100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <1142592375.7895.43.camel@homer> <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer>
In-Reply-To: <1142951339.7807.99.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220130.34424.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 01:28, Mike Galbraith wrote:
> On Wed, 2006-03-22 at 01:19 +1100, Con Kolivas wrote:
> > What you're fixing with unfairness is worth pursuing. The 'ls' issue just
> > blows my mind though for reasons I've just said. Where are the magic
> > cycles going when nothing else is running that make it take ten times
> > longer?
>
> What I was talking about when I mentioned scrolling was rendering.

I'm talking about the long standing report that 'ls' takes 10 times longer on 
2.6 90% of the time you run it, and doing 'ls | cat' makes it run as fast as 
2.4. This is what Willy has been fighting with.

Cheers,
Con
