Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261905AbSIYDuG>; Tue, 24 Sep 2002 23:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSIYDuG>; Tue, 24 Sep 2002 23:50:06 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18182
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261905AbSIYDuF>; Tue, 24 Sep 2002 23:50:05 -0400
Date: Tue, 24 Sep 2002 20:54:38 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "'Andy Pfiffer'" <andyp@osdl.org>, cgl_discussion@osdl.org,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       hardeneddrivers-discuss@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hardeneddrivers-discuss] RE: [cgl_discussion] Some Initial
 Comments on DDH-Spec-0.5h.pdf
In-Reply-To: <3D900DBA.6080400@pobox.com>
Message-ID: <Pine.LNX.4.10.10209242018450.6896-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Jeff Garzik wrote:

> Eric W. Biederman wrote:
> > Oh, and don't forget that the hardware specification that drivers are
> > written to, many times are not generally available greatly reducing 
> > the pool of capable people who have the opportunity to review the and
> > debug the drivers.  I would make it a requirement for a hardened
> > driver that both the code and the hardware documentation be publicly
> > available so the code can easily be reviewed by as many people as wish
> > to.
> 
> 
> This is a good point that bears highlighting.  Donald Becker's [and thus 
> the kernel's] eepro100.c had certain bugs for years, simply because 
> access to Intel E100 hardware docs was damn near impossible to obtain.

Jeff, 

You know that every hardware vendor will clam it works well under
MicroSoft, so why does it fail under Linux.  This is the classic one-liner
we all have gotten.  The reality is closed software is used to hide all
the flaws and failures of made by the ASIC people.  I would love to shove
the brain dead asic designer of the original PIIX4 AB/EB off a cliff on
fire for being absolutely "stupid".  Sorry this is as nice an clean as I
can say this and not dust off the flame thrower.

> I don't see driver hardening being very feasible on such drivers, where 
> the vendor refuses to allow kernel engineers access needed to get their 
> hardware working and stable.  [why vendors want crappy Linux support, 
> I'll never know]

Worse is getting a spec that says, "no work around".
When the reality is the OEM hardware vendor will not take ownership of 
their errors and disclose a good proper work-around.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

