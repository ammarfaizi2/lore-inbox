Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSHMQFk>; Tue, 13 Aug 2002 12:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHMQFk>; Tue, 13 Aug 2002 12:05:40 -0400
Received: from codepoet.org ([166.70.99.138]:49081 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318198AbSHMQFk>;
	Tue, 13 Aug 2002 12:05:40 -0400
Date: Tue, 13 Aug 2002 10:09:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-ID: <20020813160924.GA3821@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208131650230.30647-100000@localhost.localdomain> <20020813164415.A11554@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813164415.A11554@infradead.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 13, 2002 at 04:44:15PM +0100, Christoph Hellwig wrote:
> On Tue, Aug 13, 2002 at 05:09:03PM +0200, Ingo Molnar wrote:
> > 
> > the attached patch implements a new syscall on x86, clone_startup().
> > The parameters are:
> > 
> > 	clone_startup(fn, child_stack, flags, tls_desc, pid_addr)
> 
> First the name souns horrible.  What about spawn_thread or create_thread
> instead?  it's not our good old clone and not a lookalike, it's some
> pthreadish monster..

How about "clone2"?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
