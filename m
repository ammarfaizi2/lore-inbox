Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTJKQGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJKQGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:06:24 -0400
Received: from web13006.mail.yahoo.com ([216.136.174.16]:6930 "HELO
	web13006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262274AbTJKQGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:06:22 -0400
Message-ID: <20031011160621.22378.qmail@web13006.mail.yahoo.com>
Date: Sat, 11 Oct 2003 09:06:21 -0700 (PDT)
From: asdfd esadd <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model 
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200310111430.h9BEUX6s019836@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the other OS has an at this stage highly consistent
object model user along the lines of COM+ from the
kernel up encompassing a single event, thread etc.
model. Things are quite consistently wrapped, user
mode exposed if needed etc. If people were to fully
draw on it and the simpler .net BCL and not ride win32
that would (will be) a killer.  

So let me restate the need:

* a unified well architected core component model
which is extensible from OS services to application
objects

* the object model should be defined from the kernel
layer for process/events/devices etc. up and not
started at the application layer


--- Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Oct 2003 21:45:14 PDT, asdfd esadd said:
> 
> > * a unified well architected core component model
> > which is extensible
> 
> OK.. now for the terminally dense readers of the
> list like myself, could
> you repeat that in terms that people who have more
> experience in
> slinging C code than buzzwords will understand and
> rally behind?
> 
> Most of the time when I hear "component", somebody's
> trying to invent
> yet another message-passing paradigm.  And although
> there's certainly
> a place where things like CORBA and the dbus stuff
> solve problems,
> you have to remember that this is a Linux kernel,
> not Mach....
> 
> Alternatively, explain to me what this component
> model will do for us
> that updating the docs on the kernel API won't?
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
