Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbTBNMjt>; Fri, 14 Feb 2003 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268376AbTBNMjt>; Fri, 14 Feb 2003 07:39:49 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:55055 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268377AbTBNMjr>; Fri, 14 Feb 2003 07:39:47 -0500
Date: Fri, 14 Feb 2003 13:49:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-Reply-To: <20030214120628.208112C464@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302141334560.1336-100000@serv>
References: <20030214120628.208112C464@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Rusty Russell wrote:

> > It's not the same, please see: 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=104284223130775&w=2
> > I explained why the current module locking is more complex and why it's 
> > actually a three stage delete.
> 
> No, here is where you show *your* ignorance of kernel locking idioms,
> and that your axiom is that "the new system is more complex".

Well, it should be simple then to point out the problem, would you 
_please_ do it?

> > Rusty, above are real problems, the module locking fixes these problems 
> > during module_init/module_exit, but how can these problems fixed in the 
> > other cases and how does the module locking help?
> 
> This isn't even a sensible question: "This is not a module problem.
> How does module locking help?"
> 
> You're wasting your own valuable time, too.

I hoped we could discuss locking problems, as I said these problems are 
real, so it should be worth to describe possible solutions. Then we can 
compare the different locking mechanism and maybe we find one, which not 
only solves a part of the problem.

Rusty, I'm asking all these questions on purpose, I want to help you to 
understand the complete problem and how limited your solutions are. So 
either please answer my questions or point out the mistakes in my 
argumentation.

bye, Roman

