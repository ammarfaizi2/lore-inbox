Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262878AbSJAW0X>; Tue, 1 Oct 2002 18:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbSJAWUB>; Tue, 1 Oct 2002 18:20:01 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16900 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262865AbSJAWSV>;
	Tue, 1 Oct 2002 18:18:21 -0400
Date: Mon, 30 Sep 2002 06:40:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "'Andy Pfiffer'" <andyp@osdl.org>, cgl_discussion@osdl.org,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       hardeneddrivers-discuss@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hardeneddrivers-discuss] RE: [cgl_discussion] Some Initial Comments on DDH-Spec-0.5h.pdf
Message-ID: <20020930064039.A159@toy.ucw.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD01FD8CEA@orsmsx119.jf.intel.com> <3D8FC2DA.3010107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D8FC2DA.3010107@pobox.com>; from jgarzik@pobox.com on Mon, Sep 23, 2002 at 09:41:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Most of what makes a 'good' driver is common for all purposes - things you
> > mention like don't make the system hang, don't cause fatal exceptions. But
> > there are some things that would be different between a desktop, embedded
> > system, enterprise server, or carrier server. For instance, when there is a
> > tradeoff between reliability and performance; when reliability is king, it
> > might be wise to do an insane amount of parameter checking to offset the
> > merest chance of an undetected bug crashing a system.
> 
> This is not a valid example.  We do not make tradeoffs between 
> performance and reliability.  Reliability _always_ comes first.  If it 
> did not, it's a bug.

No. We do run all drivers in *one* addressspace. That's bad for reliability.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

