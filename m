Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUGVBs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUGVBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266664AbUGVBs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 21:48:59 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:62174 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266663AbUGVBs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 21:48:57 -0400
Message-ID: <170fa0d204072118483b969d22@mail.gmail.com>
Date: Wed, 21 Jul 2004 19:48:56 -0600
From: Mike Snitzer <snitzer@gmail.com>
To: "Grzegorz Ja[kiewicz" <gj@pointblue.com.pl>
Subject: Re: [PATCH] delete devfs
Cc: Jesse Stockall <stockall@magma.ca>, Greg KH <greg@kroah.com>,
       Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40FF1370.1010406@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <20040721141524.GA12564@kroah.com>	 <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com>	 <1090444782.8033.4.camel@homer.blizzard.org>	 <20040721212745.GC18110@kroah.com> <1090446817.8033.18.camel@homer.blizzard.org> <40FF1370.1010406@pointblue.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maintaining device registration and persistence all from userspace is
wonderful.  Try it, you'll like it.  Not to mention that for the
developers udev is much more easily maintained than kernel code
(devfs).  Your concern about something else ripping off udev a year
from now is misplaced; the beauty of free software is the best
solution generally wins out.  That "something else" will have to be
pretty damn amazing to upstage udev.

Mike

On Thu, 22 Jul 2004 03:08:00 +0200, Grzegorz Jaśkiewicz
<gj@pointblue.com.pl> wrote:
> Jesse Stockall wrote:
> 
> >On Wed, 2004-07-21 at 17:27, Greg KH wrote:
> >
> >
> >>It fixes an obviously broken chunk of code that is not maintained by
> >>_anyone_.  And it will clean up all device drivers a _lot_ to have this
> >>gone, which will benifit everyone in the long run.
> >>
> >>
> >>
> >
> >Agreed, but this 'broken' chunk of code is 'working' for a lot of people
> >(whether or not this is due to pure luck is not the point)
> >
> >
> >
> Personaly as many of my friends (those who use and care about kernel) we
> think that devfs is (was) the only resonable solution for /dev tree, and
> should be only one maintained. Requirement of userspace software for
> /dev is just a one big mistake. IMO in year time someone will have
> another brilliant idea, and will rip udev off. I don't think that's a
> good solution. IMO (and that was my humble opinion) devfs should be
> maintained instead of rewriting thing again, and creating problems (udev
> is not present unless userspace is up, etc).
> so for me, and many others devfs should stay as only solution :-)
> I am pretty shocked that there is no expierenced developer to maintain
> devfs. I would be delighted to do it, but I guess it's over my schledue.
> I don't have time enough to maintain my KDE stuff atm, not to mention
> kernel bits...
> 
> (no flames please, just giving my opinion).
> 
> --
> GJ
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
