Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266462AbSKOTZA>; Fri, 15 Nov 2002 14:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKOTZA>; Fri, 15 Nov 2002 14:25:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19209 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266462AbSKOTY7>; Fri, 15 Nov 2002 14:24:59 -0500
Date: Fri, 15 Nov 2002 14:29:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Nicolas Pitre <nico@cam.org>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <20021115145312.GA1320@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.96.1021115142113.10508E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Sam Ravnborg wrote:

> On Thu, Nov 14, 2002 at 07:31:24PM -0500, Bill Davidsen wrote:

> > I don't see why you ever thought it was a good idea to change this,
> > distclean is that standard target used by many other things. And perhaps
> > mrproper shouldn't bother to clean up all the leftovers, patch backups,
> > they are documentation.
> I have explained how I would like it to work - any comments on that proposal?

  Same comment, I want (a) something which will remake everything
including *versions.h to be sure I didn't mess anything up, and (b) as a
but removed the editor and patch backup files ready for distribution. I
don't want to lose the patch backup files (I care less about editor files,
my chosen editor doesn't make them) but I want to be able to easily
identify what has changed without keeping a full unmodified copy of the
tree.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

