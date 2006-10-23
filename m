Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWJWSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWJWSef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWJWSef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:34:35 -0400
Received: from www.osadl.org ([213.239.205.134]:35557 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965007AbWJWSee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:34:34 -0400
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161621286.2835.3.camel@mindpipe>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 20:35:38 +0200
Message-Id: <1161628539.22373.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 12:34 -0400, Lee Revell wrote:
> On Fri, 2006-10-20 at 11:00 -0400, Lee Revell wrote:
> > On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> > > i've released the 2.6.18-rt6 tree, which can be downloaded from the 
> > > usual place:
> > > 
> > >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > This does not work here.  It boots but then wants to fsck my disks, and
> > dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booting
> > 2.6.18-rt5 works and does not want to fsck the disks. 
> 
> I see that -rt7 is posted.  The patch is a huge diff from -rt6.  Where
> are the release notes?

Basically we merged the latest hrt-dyntick queue into -rt.

	tglx


