Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUJIBDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUJIBDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUJIBDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:03:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9951 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266427AbUJIBDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:03:40 -0400
Subject: Re: [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041008112319.63b694de.pj@sgi.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	 <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	 <20041007072842.2bafc320.pj@sgi.com> <4165A31E.4070905@watson.ibm.com>
	 <20041008061426.6a84748c.pj@sgi.com> <4166B569.60408@watson.ibm.com>
	 <20041008112319.63b694de.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097283613.6470.146.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 18:00:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 11:23, Paul Jackson wrote:
> CKRM aspires to be both a general purpose resource management framework
> and the embodiment of fair share scheduling.

I think your missing something here.  CKRM, as I understand it, aspires
to be a general purpose resource management framework.  To that point I
will accede.  But the second part, about CKRM being the embodiment of
fair share scheduling, is secondary.  That is simply one of it's
potential functions as a general purpose resource management framework. 
It could also be the embodiment of unfair scheduling, if you choose to
implement such a resource controller.  It wouldn't be very useful, but
it could be a fun exercise! ;)


> If for whatever reason, you don't think it is worth the effort to morph
> the virtual resouce manager that is currently embedded within CKRM into
> an independent, neutral framework, then don't expect the rest of us to
> embrace it.  Do you think Reiser would have gladly used vfs to plug in
> his file system if it had been called "ext"?  In my personal opinion, it
> would be foolhardy for SGI, NEC, Bull, Platform (LSF) or Altair (PBS) to
> rely on critical technology so clearly biased toward and dominated by a
> natural competitor.

I don't think that is terribly fair.  I can honestly say that I'm not
opposing your implementation because of who you work for.  I could care
less.  I'm opposing it because I think I've got an alternative that can
offer the same functionality with less impact.  I don't work on CKRM,
and when I wrote my code CKRM was not even on my radar.  If
sched_domains will play nicer with CKRM than cpusets, thats just a
bonus.  I certainly didn't design it that way!


> When someone offers you an open door ("Keep talking"), don't slam it in
> their face.  It might not open again.

*More* analogies!?! ;)


> ... keep talking ...

I warned you!

-Matt

