Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbSIYHWI>; Wed, 25 Sep 2002 03:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSIYHWI>; Wed, 25 Sep 2002 03:22:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60763 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261933AbSIYHWH>; Wed, 25 Sep 2002 03:22:07 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "'Andy Pfiffer'" <andyp@osdl.org>, cgl_discussion@osdl.org,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       hardeneddrivers-discuss@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hardeneddrivers-discuss] RE: [cgl_discussion] Some Initial Comments on DDH-Spec-0.5h.pdf
References: <Pine.LNX.4.10.10209242018450.6896-100000@master.linux-ide.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Sep 2002 01:12:14 -0600
In-Reply-To: <Pine.LNX.4.10.10209242018450.6896-100000@master.linux-ide.org>
Message-ID: <m13cryk0fl.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:


> Jeff, 
> 
> You know that every hardware vendor will clam it works well under
> MicroSoft, so why does it fail under Linux.  This is the classic one-liner
> we all have gotten.   The reality is closed software is used to hide all
> the flaws and failures of made by the ASIC people.  I would love to shove
> the brain dead asic designer of the original PIIX4 AB/EB off a cliff on
> fire for being absolutely "stupid".  Sorry this is as nice an clean as I
> can say this and not dust off the flame thrower.

Right.  So we need to get to a situation where ASIC designers are not afraid
to admit they messed up.  I have seen this from all vendors.  More than
anything this is the reason we have a documentation shortage.  Just when
we really need more documentation, and more code review to make certain
that the drivers are solid in the face of hardware bugs the vendors
stop talking.

As for ``It works well under windows so why does it fail under
Linux?'' line of arguing that is just a first reflex from people that
aren't used to dealing with Linux.  Putting it in a business case and
saying noting that the vendors can ship X million more in volume, or
become part of Y prestigious system.  People stop knee jerking and
start helping.

Getting those channels open through the business side takes time.  And
the more independent software developers don't always have access to
those kinds of arguments.  So we really need a way to shame a vendor
on a driver by driver basis that makes it worse to hide their
documentation than to admit to their bugs.  

Being able to say we could not ``harden'' the vendors driver because
the vendor did not give us the real specification, and errata
information, might be enough to shame change that.  If not we can try
other methods.

> > I don't see driver hardening being very feasible on such drivers, where 
> > the vendor refuses to allow kernel engineers access needed to get their 
> > hardware working and stable.  [why vendors want crappy Linux support, 
> > I'll never know]
> 
> Worse is getting a spec that says, "no work around".
> When the reality is the OEM hardware vendor will not take ownership of 
> their errors and disclose a good proper work-around.

If the vendor has not figured out a work around this is understandable
if undesirable.  

As for what can be done about it to get good Linux drivers, it is best
to remember that businesses do not have clear and consistent
policies.  Instead businesses are susceptible to the attack of many
pokes, and enticements by people waving cash.  So by pure persistence
and repetition we should be able to get the word out.

We just need to come up with arguments that are just as persistent as
the ip lawyers who say you need secret ``ip''.   And some
embarrassement that is stronger than the embarrassement at the quality
of their work.


Eric
