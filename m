Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbWCVUdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWCVUdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbWCVUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:33:20 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:36498 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932706AbWCVUdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:33:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [interbench numbers] Re: interactive task starvation
Date: Thu, 23 Mar 2006 07:27:50 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
References: <1142592375.7895.43.camel@homer> <1142999382.11047.34.camel@homer> <1143029650.8298.18.camel@homer>
In-Reply-To: <1143029650.8298.18.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603230727.51235.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 23:14, Mike Galbraith wrote:
> Greetings,
>
> I was asked to do some interbench runs, with various throttle settings,
> see below.  I'll not attempt to interpret results, only present raw data
> for others to examine.
>
> Tested throttling patches version is V24, because while I was compiling
> 2.6.16-rc6-mm2 in preparation for comparison, I found I'd introduced an
> SMP buglet in V23.  Something good came from the added testing whether
> the results are informative or not :)

Thanks!

I wonder why the results are affected even without any throttling settings but 
just patched in? Specifically I'm talking about deadlines met with video 
being sensitive to this. Were there any other config differences between the 
tests? Changing HZ would invalidate the results for example. Comments?

Cheers,
Con
