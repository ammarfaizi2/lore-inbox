Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272144AbTGYPNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272138AbTGYPNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:13:06 -0400
Received: from tomts23-srv.bellnexxia.net ([209.226.175.185]:42942 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S272148AbTGYPMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:12:45 -0400
Date: Fri, 25 Jul 2003 11:26:17 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: John Bradford <john@grabjohn.com>
cc: ecki-lkm@lina.inka.de, Fabian.Frederick@prov-liege.be,
       linux-kernel@vger.kernel.org
Subject: RE: why the current kernel config menu layout is a mess
In-Reply-To: <200307251458.h6PEwAMD001065@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0307251114590.26545@localhost.localdomain>
References: <200307251458.h6PEwAMD001065@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, John Bradford wrote:

> Anyway, going back to the re-design of the kernel configurator, maybe
> we have simply reached the practical limit of the simple menu based
> system?

i see no evidence of that.  i think Kconfig works fine.  i just
think it's not being used in as structured a way as it might be.
 
> There are now so many options that you either have a lot of options
> under vague headings, (which I prefer because I think that once you're
> used to it, it's quicker and simpler), or, (in my opinion), excessive
> levels of abstraction, and options deep within submenus, like:
> 
> Buses -> Internal -> Legacy -> ISA

i just want to point out that i never suggested *this* level of
sub-menuing, but even if i had, so what?  typically, when you
rebuild a kernel, you don't go through the entire menu tree every
time.  you typically want to tweak an option or two, so having
an extra level every so often is not going to be fatal.

what's important, i think, is to be able to look at the top-level
menu and be able to deduce quickly where to find the option you're
interested in.  (pop quiz:  without looking, where would you find
the option for the ftape floppy driver?  see?)

(aside:  i'm just breathless that someone could make a statement
like "a lot of options under vague headings (which I prefer ..."
you *prefer* vagueness?  someone help me out -- is mr. bradford
really this clueless, or is he just trolling at my expense?  i'm
pretty naive at times.)
 
> There are also complications with taking configurations from old
> kernel versions, and using them with later kernels - a 2.4 config
> typically won't work simply by using make oldconfig on a 2.6 tree.

oh, puhleeze.  going from one major, stable release to the next one
should be considered such a big step that you shouldn't be surprised
if you might have to do a whole, fresh kernel configuration perhaps
that one time.
 
> Maybe a completely new, out of kernel tree configurator would be worth
> thinking about, leaving the in-kernel configurator as a legacy option.
> I know the config system underwent a major overhaul during 2.5, but I
> think we could go even further.

that does it.  it's .procmailrc time for mr. bradford.  life is too
short to listen to people criticize things they don't even
understand.

rday
