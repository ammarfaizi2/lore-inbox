Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTBDTct>; Tue, 4 Feb 2003 14:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBDTct>; Tue, 4 Feb 2003 14:32:49 -0500
Received: from [81.2.122.30] ([81.2.122.30]:11785 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267437AbTBDTcs>;
	Tue, 4 Feb 2003 14:32:48 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302041940.h14JebCX002683@darkstar.example.net>
Subject: Re: PnP model
To: andrew.grover@intel.com (Grover, Andrew)
Date: Tue, 4 Feb 2003 19:40:37 +0000 (GMT)
Cc: ambx1@neo.rr.com, perex@perex.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A152@orsmsx401.jf.intel.com> from "Grover, Andrew" at Feb 04, 2003 11:25:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In many cases, Auto configuration can be better then manual 
> > configuration.
> > 1.) The auto configuration engine in my patch is able to 
> > resolve almost any
> > resource conflict and provides the greatest chance for all 
> > devices to have
> > resources allocated.
> > 2.) Certainly some driver developers would like to manually 
> > set resources
> > but many may prefer the option to auto config.
> 
> I think the people who want to manually configure their device's
> resources need to step up and justify why this is really necessary.

Prototyping an embedded system, maybe, where you have devices in the
test box that won't be in the production machine.  You would want them
to use resources other than those that you want the hardware which
will be present to use.

> If someone is manually configuring something, that means the automatic
> config *failed*.

Not necessarily.

> Why did it fail? It should never fail. Manual config is only giving
> the user to opportunity to get something wrong.

Agreed, auto configuration should never fail, but that doesn't mean
that you shouldn't have manual configuration as an option.

John.
