Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWFTQF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWFTQF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWFTQF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:05:29 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:43465 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751374AbWFTQF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:05:28 -0400
Date: Tue, 20 Jun 2006 12:05:15 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Maurice Volaski <mvolaski@aecom.yu.edu>
cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Bug 6451] CONFIG_KMOD is not set for x86_64 but is set to Y
 for i386 and other archs
In-Reply-To: <a06230977c0bdc14545ff@[129.98.90.227]>
Message-ID: <Pine.LNX.4.58.0606201159260.32334@gandalf.stny.rr.com>
References: <200606201433.k5KEXbhX003862@fire-2.osdl.org>
 <a06230977c0bdc14545ff@[129.98.90.227]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2006, Maurice Volaski wrote:

> Hey, is this you? Why on Earth do you want this setting turned off?

Maurice,

This constant pestering will only get you ignored.  If you don't like the
default, just change it, and copy over your .configs to all your machines
that you use.  Once you have done so, your makes on those machines will
use them (if you do "make install" to get the .config copied to /boot).

Now, the point you _could_ have made, is that the Help on KMOD says

   "If unsure, say Y"

Which to me _is_ a bug.  I just hate it when the default doesn't match the
recommended comment of any config option.

-- Steve


>
> >http://bugzilla.kernel.org/show_bug.cgi?id=6451
> >
> >zippel@linux-m68k.org changed:
> >
> >            What    |Removed                     |Added
> >----------------------------------------------------------------------------
> >              Status|NEW                         |REJECTED
> >          Resolution|                            |WILL_NOT_FIX
> >
> >
> >
> >------- Additional Comments From zippel@linux-m68k.org  2006-06-20
> >07:32 -------
> >This is a per architecture decision, please ask the respective maintainer.
> >
> >------- You are receiving this mail because: -------
> >You reported the bug, or are watching the reporter.
>
>
> --
>
> Maurice Volaski, mvolaski@aecom.yu.edu
> Computing Support, Rose F. Kennedy Center
> Albert Einstein College of Medicine of Yeshiva University
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
