Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTEGPHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTEGPHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:07:41 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:60050 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263811AbTEGPHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:07:37 -0400
Date: Wed, 7 May 2003 17:18:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030507151811.GC412@elf.ucw.cz>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <20030506204305.GA5546@elf.ucw.cz> <20030506221819.GC6284@mail.jlokier.co.uk> <1052256672.1983.174.camel@dhcp22.swansea.linux.org.uk> <20030506224824.GE6284@mail.jlokier.co.uk> <1052310058.3061.11.camel@dhcp22.swansea.linux.org.uk> <20030507142619.GA16023@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507142619.GA16023@mail.jlokier.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'd get to define "the OS" so that is not a problem :) You could
> > 
> > The GPL is smarter than that
> > "However, as a special exception, the source code distributed need not
> > include anything that is normally distributed (in either source or
> > binary form) with the major components (compiler, kernel, and so on) of
> > the operating system on which the executable runs, unless that component
> > itself accompanies the executable."
> 
> I am talking about replacing the kernel (and compiler as it
> happens)... those _are_ the major components of the operating system
> which fall under that exception.  So, if we were splitting hairs over
> the wording, it would come down to whether the other major components
> "accompany the executable", where the executable is the GPL module.
> 
> This is further complicated because those GPL modules need not be
> distributed in binary form anyway, they could be compiled at run time
> from source, so there is no executable to speak of.  More corner case
> fun :)

If you are compiling them from source, and interface between the
module and the kernel is well defined (== "userspace") I guess you are
okay.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
