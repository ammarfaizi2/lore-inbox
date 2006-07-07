Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWGGXXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWGGXXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWGGXWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:22:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11228 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932385AbWGGXWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:22:38 -0400
Subject: Re: Process events: Fix biarch compatibility
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060707160000.45b9a9f0.akpm@osdl.org>
References: <1152308332.21787.2178.camel@stark>
	 <20060707160000.45b9a9f0.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 16:16:00 -0700
Message-Id: <1152314160.21787.2234.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 16:00 -0700, Andrew Morton wrote:
> Matt Helsley <matthltc@us.ibm.com> wrote:
> >
> > Andrew, I'd like to revise my request and shoot for eventual inclusion
> > in 2.6.18 if it's not too much to ask. What do you think?
> 
> I'm not sure what you're referring to here.

	I'm referring only to the biarch compatability fix for process events.
It happens to tangle with but is not dependent upon task watchers. So
it's not really in the list below.

> The per-task-delay-accounting patches I'd like to get into 2.6.18, yes. 
> We've been dicking around for *years* with enhanced system accounting
> requirements and we now seem to have a roughly-agreed-upon way of doing
> that.  I think we just need to get it in there and get people using it for
> their various accounting needs.  I was planning on getting all this into
> -rc1 but then we got derailed by the 1000-cpus-doing-1000-exits-per-second
> problem.
> 
> The task-watchers patches I really like - it fixes the problem of more and
> more subsystems adding their little own little hooks all into the same
> places.  But I think it's much less urgent than per-task-delay-accounting
> and, given that (afaik) we haven't yet resolved whether task-watchers will
> use a single notifier chain or one per event, I'm inclined to hold that
> back until 2.6.19.

	Sorry for the confusion.

Cheers,
	-Matt Helsley

