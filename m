Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272151AbTGYP16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272154AbTGYP16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:27:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:22658 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272151AbTGYP1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:27:53 -0400
Date: Fri, 25 Jul 2003 16:53:02 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307251553.h6PFr2VK001246@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, rpjday@mindspring.com
Subject: RE: why the current kernel config menu layout is a mess
Cc: ecki-lkm@lina.inka.de, Fabian.Frederick@prov-liege.be,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anyway, going back to the re-design of the kernel configurator, maybe
> > we have simply reached the practical limit of the simple menu based
> > system?
>
> i see no evidence of that.  i think Kconfig works fine.  i just
> think it's not being used in as structured a way as it might be.
>  
> > There are now so many options that you either have a lot of options
> > under vague headings, (which I prefer because I think that once you're
> > used to it, it's quicker and simpler), or, (in my opinion), excessive
> > levels of abstraction, and options deep within submenus, like:
> > 
> > Buses -> Internal -> Legacy -> ISA
>
> i just want to point out that i never suggested *this* level of
> sub-menuing

We are approaching it anyway, with more and more options being added.

> , but even if i had, so what?  typically, when you
> rebuild a kernel, you don't go through the entire menu tree every
> time.  you typically want to tweak an option or two, so having
> an extra level every so often is not going to be fatal.

Wrong.  I compile kernels for lots of different machines, all the
time.  I'm not just sat in front of one box, recompiling more or less
the same kernel all day.  They are usually each configured from
scratch, except when there are several identical boxes.

> what's important, i think, is to be able to look at the top-level
> menu and be able to deduce quickly where to find the option you're
> interested in.  (pop quiz:  without looking, where would you find
> the option for the ftape floppy driver?  see?)

Character devices.  No, I didn't look first, by the way.  It's been
there since at least 1.2.X.

> (aside:  i'm just breathless that someone could make a statement
> like "a lot of options under vague headings (which I prefer ..."
> you *prefer* vagueness?

YES!!!  Because it's only vague for people who aren't used to it.

> someone help me out -- is mr. bradford really this clueless, or is
> he just trolling at my expense?  i'm pretty naive at times.)

Try looking at:

* My previous contributions to this list

* The bug database I've spent six months working on, on and off.

* My website

You decide whether I am a 'troll' or not.

> > There are also complications with taking configurations from old
> > kernel versions, and using them with later kernels - a 2.4 config
> > typically won't work simply by using make oldconfig on a 2.6 tree.
>
> oh, puhleeze.  going from one major, stable release to the next one
> should be considered such a big step that you shouldn't be surprised
> if you might have to do a whole, fresh kernel configuration perhaps
> that one time.

Please don't talk down to me.  The new users who you seem to be trying
to help, may well want to use their existing .config as a base for
their new one - moving from their distribution's 2.4 kernel to the 2.6
kernel may be the whole reason that they suddenly want to compile
their own kernel, whereas they have been happy with their
distribution's one up until now.

> > Maybe a completely new, out of kernel tree configurator would be worth
> > thinking about, leaving the in-kernel configurator as a legacy option.
> > I know the config system underwent a major overhaul during 2.5, but I
> > think we could go even further.
>
> that does it.  it's .procmailrc time for mr. bradford.  life is too
> short to listen to people criticize things they don't even
> understand.

Although I might criticize things, I provide code to back up my
criticisms.  I didn't like the kernel Bugzilla, so I wrote an
alternative.  More people use the kernel Bugzilla than my bug
database, so quite possibly I was wrong, _but_ instead of posting
hypothetical questions to this list, I wrote an alternative.  It's
been mentioned in Kernel Traffic, a Linux magazine, and on lots of
websites.

John.
