Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUJIUap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUJIUap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUJIUNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:13:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3535 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267362AbUJIULu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:11:50 -0400
Date: Sat, 9 Oct 2004 13:08:08 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: frankeh@watson.ibm.com, ricklind@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] Re: [PATCH] cpusets - big numa cpu and memory
 placement
Message-Id: <20041009130808.70c56ea3.pj@sgi.com>
In-Reply-To: <1097283613.6470.146.camel@arrakis>
References: <20041007015107.53d191d4.pj@sgi.com>
	<200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	<20041007072842.2bafc320.pj@sgi.com>
	<4165A31E.4070905@watson.ibm.com>
	<20041008061426.6a84748c.pj@sgi.com>
	<4166B569.60408@watson.ibm.com>
	<20041008112319.63b694de.pj@sgi.com>
	<1097283613.6470.146.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthrew, responding to Paul:
> > If for whatever reason, you don't think it is worth the effort to morph
> > the virtual resouce manager that is currently embedded within CKRM into
> > an independent, neutral framework, then don't expect the rest of us to
> > embrace it.  Do you think Reiser would have gladly used vfs to plug in
> > his file system if it had been called "ext"?  In my personal opinion, it
> > would be foolhardy for SGI, NEC, Bull, Platform (LSF) or Altair (PBS) to
> > rely on critical technology so clearly biased toward and dominated by a
> > natural competitor.
> 
> I don't think that is terribly fair.  I can honestly say that I'm not
> opposing your implementation because of who you work for. 

Good point.  I was painting with too wide a brush (hmmm ... someday I
should see if I can get through an entire post without an analogy ...)

When people show a good ability to work with others on lkml who have a
shared interest and sufficient competence in an area, then it doesn't
much matter what company they work for.  I see such a discussion
happening on another portion of this thread, with yourself, Nick, Peter
and Erich, involving the domain scheduler.  That works well.

So far I have been unable to achieve confidence in my ability to
interact well with the key CKRM folks.  In various ways, I have found
their project, and their demeanor on this list, to be difficult for me
to approach.

Normally this wouldn't matter.  However Andrew and others have proposed
that cpusets have a critical dependency on CKRM.  Now it matters.

If I am to have a critical project dependency on an external group with
whom I lack confidence that we share sufficient common interest and a
healthy ability to communicate, then I prefer a more adversarial style
of relations, with explicit contracts, minimum clearly defined and
verifiable deliverables, and suitable fallback contingencies in place.
I keep a sharp eye out for potential conflicts of interest.

My suggestion to separate the virtual resource management framework
(which I named 'vrm') from CKRM's other elements, such as fair share
scheduling, was an attempt to establish such a minimum verifiable
deliverable.  That suggestion was clearly dead on arrival.

My apologies for implicating everyone whose email ends in "ibm.com" in
my earlier comment.  IBM is a big place, and all manner and variety
of people work there.  It's a pleasure working with yourself, Matthew,
and many others from IBM.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
