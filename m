Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbSLEU6z>; Thu, 5 Dec 2002 15:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbSLEU54>; Thu, 5 Dec 2002 15:57:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:27603 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267390AbSLEU4t>;
	Thu, 5 Dec 2002 15:56:49 -0500
Date: Thu, 5 Dec 2002 18:31:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021205173145.GB731@elf.ucw.cz>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212031247.07284.EricAltendorf@orst.edu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
> > >> I get:
> > >>
> > >> arch/i386/kernel/built-in.o(.data+0x1304): In function
> > >
> > > `do_suspend_lowlevel':
> > >> : undefined reference to `save_processor_state'
> > >>
> > >> arch/i386/kernel/built-in.o(.data+0x130a): In function
> > >
> > > `do_suspend_lowlevel':
> > >> : undefined reference to `saved_context_esp'
> > >
> > > Try turning on software suspend in the kernel hacking section.
> >
> > It is off (and has been all the time, AFAIR).
> 
> Right ... I'm no kernel hacker so I don't know why, but I can only get 
> the recent kernels to compile with sleep states if I turn *ON* 
> software suspend as well.  However, as soon as I turn on swsusp and 
> get a compiled kernel, it oops'es on boot.

Can you mail me decoded oops?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
