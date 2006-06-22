Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWFVOZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWFVOZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWFVOZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:25:55 -0400
Received: from www.osadl.org ([213.239.205.134]:25314 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751800AbWFVOZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:25:07 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0606221021410.15236@gandalf.stny.rr.com>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
	 <1150824092.6780.255.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
	 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
	 <1150907165.25491.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0606220936290.15236@gandalf.stny.rr.com>
	 <1150986041.25491.53.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0606221021410.15236@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 16:26:35 +0200
Message-Id: <1150986396.25491.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 10:23 -0400, Steven Rostedt wrote:
> > What's nasty ?
> >
> 
> The fact that sched_setscheduler can never be called by interrupt context.
> So I don't know how you're going to handle the high_res dynamic priority
> now.

Thats a seperate issue. Though you are right.

	tglx


