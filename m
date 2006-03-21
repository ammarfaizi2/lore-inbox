Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWCUOUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWCUOUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWCUOUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:20:12 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:37002 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030402AbWCUOUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:20:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 01:19:49 +1100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <1142592375.7895.43.camel@homer> <200603220053.53595.kernel@kolivas.org> <1142950651.7807.95.camel@homer>
In-Reply-To: <1142950651.7807.95.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220119.50331.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 01:17, Mike Galbraith wrote:
> On Wed, 2006-03-22 at 00:53 +1100, Con Kolivas wrote:
> > The yardstick for changes is now the speed of 'ls' scrolling in the
> > console. Where exactly are those extra cycles going I wonder? Do you
> > think the scheduler somehow makes the cpu idle doing nothing in that
> > timespace? Clearly that's not true, and userspace is making something
> > spin unnecessarily, but we're gonna fix that by modifying the
> > scheduler.... sigh
>
> *Blink*
>
> Are you having a bad hair day??

My hair is approximately 3mm long so it's kinda hard for that to happen. 

What you're fixing with unfairness is worth pursuing. The 'ls' issue just 
blows my mind though for reasons I've just said. Where are the magic cycles 
going when nothing else is running that make it take ten times longer?

Cheers,
Con
