Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSFZWKn>; Wed, 26 Jun 2002 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317016AbSFZWKm>; Wed, 26 Jun 2002 18:10:42 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:2217 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S317006AbSFZWKl>;
	Wed, 26 Jun 2002 18:10:41 -0400
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
From: Bongani <bonganilinux@mweb.co.za>
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1025128477.1144.3.camel@icbm>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
	<20020626204721.GK22961@holomorphy.com>
	<1025125214.1911.40.camel@localhost.localdomain> 
	<1025128477.1144.3.camel@icbm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7-1mdk 
Date: 27 Jun 2002 00:12:07 +0200
Message-Id: <1025129557.2189.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I was confusing the preemptive patch with the O(1) patch
I just remember that you worked on a patch for -ac ;) 



On Wed, 2002-06-26 at 23:54, Robert Love wrote:
> On Wed, 2002-06-26 at 17:00, Bongani wrote:
> > IIRC the preemptive patch is now part of -ac
> 
> The preemptive kernel is not part of 2.4-ac.
> 
> Btw, fwiw, I do not think this problem has anything to do with
> preemption.  The "exited with preempt_count" message just means the task
> exited with preemption disabled.  It is not a problem if the task died
> abnormally.
> 
> 	Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


