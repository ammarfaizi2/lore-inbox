Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTJWUeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTJWUeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:34:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:37571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261799AbTJWUeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:34:18 -0400
Date: Thu, 23 Oct 2003 13:35:02 -0700
From: Dave Olien <dmo@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rwhron@earthlink.net, venom@sns.it, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031023203502.GA12778@osdl.org>
References: <20031021130501.GA4409@rushmore> <3F9653E6.4060209@cyberone.com.au> <20031022183028.GA10249@osdl.org> <3F973BC9.4080005@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F973BC9.4080005@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


test5 didn't work with dbt2.  The database run kept hanging.
I've been running reaim, which doesn't have those problems with
older kernels, but has shown similar performance problems.

I need to also check again that reaim and dbt2 still show similar
performance issues with newer kernel versions.

I've lost my test machine for today.  But I'll try test5 as-iosched
in a test8 kernel with reaim tomorrow.  If it works well, I'll try your
following patch.  Probably get it in the mail tomorrow afternoon.

Dave

On Thu, Oct 23, 2003 at 12:24:09PM +1000, Nick Piggin wrote:
> 
> 
> Dave Olien wrote:
> 
> >Sorry, this patch didn't fix our performance problems.  Mary just
> >finished running dbt2 on test8 with your patch:
> >
> >NOTPM   kernel          scheduler
> >965     2.6.0-test8-np  AS
> >1632    2.6.-test6-mm4  deadline
> >
> 
> Thanks. hmm.
> And NOTPM was better with AS in test5? Does using as-iosched.c from test5
> in a test8 kernel help?
> 
