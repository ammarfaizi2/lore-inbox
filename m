Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbUAJTfP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265350AbUAJTeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:34:09 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:3456 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265344AbUAJTdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:33:09 -0500
Date: Sat, 10 Jan 2004 20:34:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: George Anzinger <george@mvista.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
Message-ID: <20040110193406.GA241@elf.ucw.cz>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110175607.GH18208@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >>>Hi!
> > >>>
> > >>>No real code changes, but cleanups all over the place. What about
> > >>>applying?
> > >>>
> > >>>Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
> > >>>do x86-64 version so that is rather important.
> > >>>
> > >>>								Pavel
> > >>
> > >>A few comments:
> > >>
> > >>I like the code seperation.  Does it follow what Amit is doing?  It would 
> > >>be nice if Amit's version and this one could come together around this.
> > >>
> > >>I don't think we want to merge the eth and regular kgdb just yet.  I 
> > >>would, however, like to keep eth completly out of the stub.  Possibly a 
> > >>new module which just takes care of steering the I/O to the correct place.
> > >
> > >
> > >I've sent Amit the start of an plug interface for abstracting the
> > >communication layer. Should be relatively painless and allow for
> > >starting sessions on the interface of your choice.
> > >
> > May I see?
> 
> Here's the interface plus the eth side of it:

Does it work with those patches? (Amid's version does not seem to work
over ethernet).
								Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
