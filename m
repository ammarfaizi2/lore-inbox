Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTEISgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTEISgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:36:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35205 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262285AbTEISgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:36:13 -0400
Date: Fri, 9 May 2003 14:27:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <200305091309_MC3-1-3826-6B65@compuserve.com>
Message-ID: <Pine.LNX.4.53.0305091345210.25319@chaos>
References: <200305091309_MC3-1-3826-6B65@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Chuck Ebbert wrote:

> Alan Cox wrote:
>
> >>   Security-sensitive upper layers like virus scanners and loggers
> >> would want to do it that way.  The upper layer might even just log
> >> the fact that mount happened and then stay out of the way after that.
> >
> > What makes you say that. If the administrator has full priviledges then
> > its kind of irrelevant trying to force anything "for security reasons"
>
>   Check out the NSA's guide for securing Win2k machines sometime.  They
> go through all kinds of steps to separate auditing and administration
> even though an administrator can get around them and play with the audit
> trail anyway.  It raises the bar and removes the defense of plausible
> deniability if an admin gets caught (he can hardly claim it was an
> 'accident' that he granted himself audit privileges and then used them
> to tamper with the audit log.)
>
>         1.  Create a new group: Auditors
>         2.  Grant these rights to Auditors:
>                 Take ownership of files; Manage auditing
>         3.  Create a new user: Auditor, and put it in these groups:
>                 Users; Auditors
>         4.  Log on as Auditor and take ownership of
>                 %systemroot%\system32\config\SecEvent.Evt
>         5.  Set permissions on that security logfile:
>                 a. System: full control
>                 b. Administrators: no access
>                 c. Auditors: full control
>         6.  Now log on as an administrator and take away these rights:
>                 a. from Administrators: Manage auditing
>                 b. from Auditors: Take ownership of files
>         7.  Enable these extra security options:
>                 a. crash on audit failure
>                 b. clear page file on shutdown
>                 c. full privilege auditing
>                 d. lots more...
>
> After setting up auditing and ACLs (many pages of directions for that)
> the audit duties are done by unprivileged users and administrators
> cannot see or alter the audit trail.
>
>   Seems like a lot of useless work given that the admins can grant
> themselves any rights they want, doesn't it?

It's to make it look like it's secure. If you have a system
with no executable software, other than what is built in,
that can't execute other software because there is no built-
in code to do it, the system is still only secure when it's
powered OFF. Microsoft installed Magic Lantern software within
the kernel and within all software updates, (service Pack 2 of
Win/2000/Prof as part of their deal with the Justice Department
when our attention was diverted after 9/11. This allows any
"Duly Authorized...." person to extract the contents of anything,
any time it's on the network. Magic Lantern is the hook for
"Carnivore" (and others) that uses bits in the same packet area
as the ECN bits to tell the M$ kernel not to forward the attached
packet on to mail, but to use it as a command for an internal spy
engine that sends information back using the same methods. Since
most all fire-walls are open to the mail port. This is the way the
United States Government can look into every machine on the network.

This was originally conceived as a key-stoke logger and hook for
Magic Eye, Network Eye, PC Anywhere, and other such "tools".
Originally the FBI actually had to enter your home and install
it. Now it happens automatically to everybody, just by installing
Windows.

So, there is a device in 30 percent of American Homes that
violates personal privacy, thanks to John Aschroft and the
do-nothing-but-spend Congress that allows him to rape, rob,
pillage and plunder without respect for the Constitution.
Just think what's happening right now in countries where you
are not allowed to speak of such things!

Since there are so many machines, interconnected, there is
some security-by-obscurity, but once the Justice Department
has an idea of what machine to look into, the rest is
trivial.

It is absolutely absurd that somebody thinks that they can
"secure" a Win2k machine. It is absolutely impossible. Any
such document from the NSA has got to be a ruse, used to
make the "enemy" think that some machine they mucked with
is secure. They certainly know better.

Incidentally, I bought a cable modem for somebody in
Californa (I live near New Hampshire, no sales tax). Just
for kicks, I connected it to my cable and hooked up my
lap-top which uses M$ and dynamic IPs. In a few seconds
I had a free connection to the Internet. Even the networks
don't have any security!  They don't even know who their
"customers" are!  I could be running an terrorist cell off
that connection and nobody would know. But, in the meantime
the government arrests some (ex) Intel Software Engineer
and charges him with supporting terriorism because he had
some, possibly-connected, person mow his lawn (See this
weeks' EETimes). It should scare the hell out of everybody.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

