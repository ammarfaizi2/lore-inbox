Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVGUXcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVGUXcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 19:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGUXcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 19:32:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45957 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261955AbVGUXcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 19:32:53 -0400
Date: Thu, 21 Jul 2005 16:32:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Matthew Helsley <matthltc@us.ibm.com>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       gh@us.ibm.com
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
Message-Id: <20050721163227.661a5169.pj@sgi.com>
In-Reply-To: <1121985448.5242.90.camel@stark>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715150034.GA6192@infradead.org>
	<20050715131610.25c25c15.akpm@osdl.org>
	<20050717082000.349b391f.pj@sgi.com>
	<1121985448.5242.90.camel@stark>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> I don't see the large ifdefs you're referring to in -mm's
> kernel/sched.c.

Perhaps someone who knows CKRM better than I can explain why the CKRM
version in some SuSE releases based on 2.6.5 kernels has substantial
code and some large ifdef's in sched.c, but the CKRM in *-mm doesn't.
Or perhaps I'm confused.  There's a good chance that this represents
ongoing improvements that CKRM is making to reduce their footprint
in core kernel code.  Or perhaps there is a more sophisticated cpu
controller in the SuSE kernel.


> Have you looked at more
> recent benchmarks posted on CKRM-Tech around April 15th 2005?
> ...
> http://ckrm.sourceforge.net/downloads/ckrm-ols04-slides.pdf 

I had not seen these before.  Thanks for the pointer.


> The Rule-Based Classification Engine (RBCE) makes CKRM useful
> without middleware.

I'd be encouraged more if this went one step further, past pointing
out that the API can be manipulated from the shell without requiring C
code, to providing examples of who intends to _directly_ use this
interface. The issue is perhaps less whether it's API is naturally C or
shell code, or more of how many actual, independent, uses of this API
are known to the community.  A non-trivial API and mechanism that
is de facto captive to a single middleware implementation (which
may or may not apply here - I don't know) creates an additional review
burden, because some of the natural forces that guide us to healthy
long lasting interfaces are missing.  If that concern applies here,
it's certainly not insurmountable - but it should in my view raise the
review barrier to acceptance.  If other middleware or direct users
are not essentially performing some of the review for us, we have to do
it here with greater thoroughness.


> If you could be more specific I'd be able to
> respond in less general and abstract terms.

Good come back <grin>.

I made an effort along these lines last year, in the thread
I referenced a few days ago:

    Classes: 1) what are they, 2) what is their name?
    http://sourceforge.net/mailarchive/forum.php?thread_id=5328162&forum_id=35191

I doubt that it I have much more to contribute along
these lines now.

Sorry.

> I haven't seen this limitation [128 cpus] ...

Good - I presume that there is no longer, if there ever was, such a
limitation.

Thanks for you reply.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
