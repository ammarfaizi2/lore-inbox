Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbULaRPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbULaRPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbULaRPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:15:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:31148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbULaRPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:15:00 -0500
Date: Fri, 31 Dec 2004 09:14:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041231123538.GA18209@muc.de>
Message-ID: <Pine.LNX.4.58.0412310912310.2280@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <m1mzvvjs3k.fsf@muc.de>
 <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org> <20041231123538.GA18209@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Dec 2004, Andi Kleen wrote:
> 
> >  - you couldn't even debug signal handlers, because they were _really_ 
> >    hard to get into unless you knew where they were and put a breakpoint 
> >    on them.
> 
> Ok I see this as being a problem. But I bet it could be fixed
> much simpler without doing all this complicated and likely-to-be-buggy
> popf parsing you added.

And that is _exactly_ what we did.

Guess what broke Wine?

Uhhuh. 

		Linus
