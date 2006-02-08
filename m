Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWBHKoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWBHKoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWBHKoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:44:06 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17382 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030283AbWBHKoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:44:04 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060208102500.GA10942@elte.hu>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <20060208102500.GA10942@elte.hu>
Date: Wed, 08 Feb 2006 11:47:02 +0100
Message-Id: <1139395622.23722.0.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/02/2006 11:44:55,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/02/2006 11:44:58,
	Serialize complete at 08/02/2006 11:44:58
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 11:25 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > >   I've been experimenting with 2.6.15-rt16 on a dual 2.8GHz Xeon box
> > > with quite good results and decided to make a run on a NUMA dual node
> > > IBM x440 (8 1.4GHz Xeon, 28GB ram).
> > >
> > >   However, the kernel crashes early when creating the slabs. Does the
> > > current preempt-rt patchset supports NUMA machines or has support
> > > been disabled until things settle down?
> > 
> > Yeah, currently the -rt patch doesn't work well with NUMA.
> 
> FYI, i've got a new port of upstream slab.c to -rt, which should work on 
> NUMA too. It'll be in -rt17 (later today or tomorrow).
> 
> 	Ingo

  Great, I sure will try it.

  Thanks.

  Sébastien.


