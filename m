Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTLLF3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 00:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLLF2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 00:28:17 -0500
Received: from dp.samba.org ([66.70.73.150]:35270 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264488AbTLLF2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 00:28:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch] quite down SMP boot messages 
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>, jbarnes@sgi.com,
       Jes Sorensen <jes@wildopensource.com>
In-reply-to: Your message of "Thu, 11 Dec 2003 19:48:18 -0000."
             <20031211194818.A25999@infradead.org> 
Date: Fri, 12 Dec 2003 12:50:43 +1100
Message-Id: <20031212052813.062F82C0C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031211194818.A25999@infradead.org> you write:
> On Thu, Dec 11, 2003 at 08:30:52AM -0500, Jes Sorensen wrote:
> > Once you hit > 2 CPUs the amount of noise printed per CPU starts
> > becoming a pain, at 64 CPUs it's turning into a royal pain ....
> 
> Just kill the silly option, these messages are completly useless.
> And IIRC we didn't have them in 2.4 either..

Agreed.  We got v. chatty during 2.5.  In 2.6.<smallnum> we should
drop a lot of boot crud.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
