Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284903AbRLFAVb>; Wed, 5 Dec 2001 19:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbRLFAQL>; Wed, 5 Dec 2001 19:16:11 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:22517 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284892AbRLFAP7>; Wed, 5 Dec 2001 19:15:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Wed, 5 Dec 2001 09:51:13 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0112041833150.3798-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112041833150.3798-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206001558.OQCD485.femail3.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 December 2001 12:43 pm, Dave Jones wrote:
> On Tue, 4 Dec 2001, Eric S. Raymond wrote:
> > After CML2 has proven itself in 2.5, I do plan to go back to Marcelo
> > and lobby for him accepting it into 2.4, on the grounds that doing so
> > will simplify his maintainance task no end.
> > ...
> > I'm just going to say "Today's problems, today's tools."
>
> So anyone perfectly happy with an older distro that didn't
> ship python2-and-whatever-else gets screwed when they want to
> build a newer kernel. Nice.
>
> Dave.

1) Moving from 2.2->2.4, it wouldn't work at all without a newer compiler and 
newer modutils, and it really helped to have a C library and eight zillion 
other things upgraded.  So talking about what 2.6 will need that's an amazing 
red herring.

2) In terms of a 2.4 backport, if the old stuff isn't removed (the current 
garbage that does menuconfig et al), then who cares?  It's another option 
they don't have to use.  It's also Marcelo's call.

3) The fact Linus was cc'd on this before I trimmed it suggests to me that 
people are still wishfully thinking that the battle they lost before the 
linux-kernel summit would just magically re-open at the last minute.  It's 
not about the fact that reiserfs, ext3, and a new VM subsystem went into 2.4 
but THIS is way too much, it's a group of people bitching about python 
because they don't like the concept of significant whitespace.  Technically 
speaking, this is another variant of the good old indentation/coding style 
thread that just won't die.

It's insidious, isn't it?

Rob

