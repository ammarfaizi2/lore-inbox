Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTJKRN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTJKRN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:13:58 -0400
Received: from web13008.mail.yahoo.com ([216.136.174.18]:43020 "HELO
	web13008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263333AbTJKRN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:13:56 -0400
Message-ID: <20031011171355.60258.qmail@web13008.mail.yahoo.com>
Date: Sat, 11 Oct 2003 10:13:55 -0700 (PDT)
From: asdfd esadd <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model 
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200310111648.h9BGmZ6s026348@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


unfortunately it's rather a jump into elegance. The
other OS component model is quite well architected.
Hence what's needed is _a similar architecture effort
which may _abstract many things in the beginning to be
filled in later. Ther's a dire need for a sound and
similarly elegant (or better) model. 

There can still be many e.g. widget libraries for GUIs
but if new ones were to build on a common model  (or
wrapped) Linux would kill Windows through the by now
larger base of contributors. If that apparent lack of
architecture guidance continues we get another dozen
class libraries for everything for each application
nicely exposing it which then nobody learns/uses. With
a common object model Linux can push the envelope,
without it it's leaving it to others. 


--- Valdis.Kletnieks@vt.edu wrote:
> On Sat, 11 Oct 2003 09:06:21 PDT, you said:
> > 
> > the other OS has an at this stage highly
> consistent
> > object model user along the lines of COM+ from the
> > kernel up encompassing a single event, thread etc.
> > model. Things are quite consistently wrapped, user
> > mode exposed if needed etc. If people were to
> fully
> > draw on it and the simpler .net BCL and not ride
> win32
> > that would (will be) a killer.  
> 
> If all your friends jumped off a cliff, would you do
> it too?
> 
> I submit to you that the reason The Other OS needs
> the concept of a object
> model from the kernel through to user space is
> because the architects had a
> very fuzzy concept of "boundary".  Yes, you need
> stuff like that if your GUI
> and your IIS (yes, really, Win2003 apparently has
> IIS on the kernel side of the
> boundary now).  If you have a syscall interface, the
> kernel is free to
> implement read() in any way it wants, and the
> userspace calling read() is able
> to use it for pretty much anything.
> 
> Ask yourself:  (a) Could I implement .NET in
> userspace using the supplied syscalls?
> (b) If .NET was implemented and enforced
> kernel-side, could I implement CORBA?
> 
> Remember - it's quite possible that the user wants
> some OTHER GUI, or some
> OTHER thread model, or some OTHER.....  We're not
> the operating system run by
> jackboots.
> 
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
