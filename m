Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSJZKdS>; Sat, 26 Oct 2002 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSJZKc6>; Sat, 26 Oct 2002 06:32:58 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:41228 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262100AbSJZKb5>; Sat, 26 Oct 2002 06:31:57 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Mon, 21 Oct 2002 17:17:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Gross <markgross@thegnar.org>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021021151747.GA227@elf.ucw.cz>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <200210171835.21647.markgross@thegnar.org> <20021018021242.GA15853@averell> <200210171958.23198.markgross@thegnar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210171958.23198.markgross@thegnar.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I want the x86 CPU error code, which often has interesting clues on the
> > problem. trapno would be useful too. I suspect other CPUs have similar
> > extended state for exceptions.
> >
> > I usually hack my kernel to printk() it, but having it in the coredump
> > would be more general and you can look at it later.
> >
> > Eventually (in a future kernel) I would love to have the exception
> > handler save the last branch debugging registers of the CPU and the let the
> > core dumper put that into the dump too.  Then you could easily
> > figure out what the program did shortly before the crash.
> >
> > -Andi
> 
> Having the last branch before a crash would be cool.  Its easy to
> add note 

How do you get that info in the first place? I do not think CPU stores
info about last branch it did...
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
