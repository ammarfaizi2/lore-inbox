Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUJJCat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUJJCat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUJJCat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:30:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60563 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268069AbUJJCar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:30:47 -0400
Date: Sat, 9 Oct 2004 19:28:23 -0700
From: Paul Jackson <pj@sgi.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: colpatch@us.ibm.com, mbligh@aracnet.com, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041009192823.4ffdfb3c.pj@sgi.com>
In-Reply-To: <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
References: <20041007072842.2bafc320.pj@sgi.com>
	<200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick wrote:
> One does?  No, in my world, there's constant auditing going on and if
> you can get away with having a machine idle, power to ya, but chances
> are somebody's going to come and take away at least the cycles and maybe

I don't doubt that such worlds as yours exist, nor that you live in one.

In some of the worlds my customers live in, they have been hit so many
times with the pains of performance degradation and variation due to
unwanted interaction between applications that they get nervous if a
supposedly unused CPU or Memory looks to be in use.  Just the common use
by Linux of unused memory to keep old pages in cache upsets them.

And, perhaps more to the point, while indeed some other department may
soon show up to make use of those lost cycles, the computer had jolly
well better leave those cycles lost _until_ the customer decides to use
them.

Unlike the computer in my dentists office, which should "just do it",
maximizing throughput as best it can, not asking any questions, the
computers in some of my customers high end shops are managed more tightly
(sometimes very tightly) and they expect to control load placement.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
