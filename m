Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVFABao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFABao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFABao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:30:44 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:9198 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261185AbVFABai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:30:38 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: karim@opersys.com
Cc: Philippe Gerum <rpm@xenomai.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>, Esben Nielsen <simlo@phys.au.dk>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <429D0C13.3000006@opersys.com>
References: <20050531143051.GL5413@g5.random>
	 <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk>
	 <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com>
	 <20050531204544.GU5413@g5.random>  <429D0C13.3000006@opersys.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 21:30:25 -0400
Message-Id: <1117589425.4749.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 21:14 -0400, Karim Yaghmour wrote:

> Please have a look at RTAI-fusion. It provides deterministic
> replacements for rt-able syscalls _transparently_ to STANDARD
> Linux applications. For example, an unmodified Linux application
> can get a deterministic nanosleep() via RTAI-fusion. The way
> this works, is that rtai-fusion catches the syscalls prior to
> them reaching Linux. So even the syscall thing isn't really a
> limitation for RTAI anymore.

This looks very interesting.  I need to read more into RTAI and friends
when I get a chance.  I just received the latest Linux Journal that has
the article about the use of RTLinux with the control of magnetic
bearings.  I've just started reading it so I don't know all the details
yet but it still looks very promising. 

I don't think the adding of preempt-RT patch to the kernel will hurt
anything. In fact I think it may even help out the RTAI and friends.
Anyway, as it has been stated, this discussion has started too early.
(Thanks Daniel ;-)

-- Steve

This is the 279th message on this thread (not counting Lee's recent
"human timing" offshoot)

