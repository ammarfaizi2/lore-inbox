Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268436AbTBNNMg>; Fri, 14 Feb 2003 08:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbTBNNMf>; Fri, 14 Feb 2003 08:12:35 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:44043 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268436AbTBNNL5>; Fri, 14 Feb 2003 08:11:57 -0500
Date: Fri, 14 Feb 2003 14:21:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-Reply-To: <20030214120628.208112C464@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302141410540.1336-100000@serv>
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

Another point you probably misunderstood: I said that the complexity of 
the new and the old system is exactly the same, please read more carefully 
before flaming, it might backfire.

> > Rusty, above are real problems, the module locking fixes these problems 
> > during module_init/module_exit, but how can these problems fixed in the 
> > other cases and how does the module locking help?
> 
> This isn't even a sensible question: "This is not a module problem.
> How does module locking help?"

I hate to drag people into a discussion, but maybe you're more inclined 
to believe Al:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103761331525509&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103769023500378&w=2

Please read this very careful and think about it.

bye, Roman

