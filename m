Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWCXAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWCXAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWCXAV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:21:27 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:18663 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030182AbWCXAV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:21:26 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [interbench numbers] Re: interactive task starvation
Date: Fri, 24 Mar 2006 11:21:01 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
References: <1142592375.7895.43.camel@homer> <1143093229.9303.1.camel@homer> <1143112045.9065.15.camel@homer>
In-Reply-To: <1143112045.9065.15.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241121.02868.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 22:07, Mike Galbraith wrote:
> Nothing conclusive.  Some of the difference may be because interbench
> has a dependency on the idle sleep path popping tasks in a prio 16
> instead of 18.  Some of it may be because I'm not restricting IO, doing
> that makes a bit of difference.  Some of it is definitely plain old
> jitter.

Thanks for those! Just a clarification please

> virgin

I assume 2.6.16-rc6-mm2 ?

> throttle patches with throttling disabled

With your full patchset but no throttling enabled?

> minus idle sleep

Full patchset -throttling-idlesleep ?

> minus don't restrict IO

Full patchset -throttling-idlesleep-restrictio ?

Can you please email the latest separate patches so we can see them in 
isolation? I promise I won't ask for any more interbench numbers any time 
soon :)

Thanks!

Cheers,
Con
