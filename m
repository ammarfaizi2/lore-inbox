Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWGLCvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGLCvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 22:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGLCvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 22:51:13 -0400
Received: from xenotime.net ([66.160.160.81]:32456 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932356AbWGLCvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 22:51:13 -0400
Date: Tue, 11 Jul 2006 19:54:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Gustavo Guillermo =?ISO-8859-1?B?UOlyZXo=?= 
	<gustavo@compunauta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium D on GW fail to boot with 2.6.16/17 but not with
 2.6.11/12/13/14/15
Message-Id: <20060711195401.1045c8dd.rdunlap@xenotime.net>
In-Reply-To: <200607112104.03673.gustavo@compunauta.com>
References: <200607111906.06343.gustavo@compunauta.com>
	<200607112032.51788.gustavo@compunauta.com>
	<200607112104.03673.gustavo@compunauta.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 21:04:02 -0500 Gustavo Guillermo Pérez wrote:

> booting kernel 2.6.15 with all drivers compiled, and loading Intelfb agp-intel 
> the oops appears, I'm using an extra NVidia card.
> 
> Deleting the intel810 and friends the oops disappear.

Can you capture any oops messages?  (without using any
proprietary drivers)


> El Martes, 11 de Julio de 2006 20:32, Gustavo Guillermo Pérez escribió:
> > Reviewing my experiments I was discover that the problem start at 2.6.16,
> > cause going forward from 2.6.11 to 2.6.15 there is no problem in smp or
> > single mode.
> >
> > El Martes, 11 de Julio de 2006 19:06, Gustavo Guillermo Pérez escribió:
> > > Hello list, I was trying to use a newer kernel on a gentoo installation,
> > > and I've downloaded a lastest kernel 2.6.17/16 getting a hardlock on boot
> > > time, with or without smp mode, controlled by BIOS or by smp kernel
> > > option I got 1 penguin or 2 penguins as processors get detected, it just
> > > hang after frame buffer or agp detection, but using vga=0 to not see any
> > > frame buffer I got a so faster oops and kernel panic and machine reboots,
> > > then I can't see anything on the screen, just with frame buffer enabled,
> > > but with frame buffer enabled does not work SySREQ, is just a hang.
> > >
> > > Attached .config file used, cat /proc/cpuinfo with 2.6.11 that was the
> > > kernel that can be built for, and lspci, and verbose lspci.
> > >
> > > The config file is the same used for the tests, with or without frame
> > > buffer enabled is the same.
> > >
> > > BIOS VERSION NT94510J.15A.0065.2005.1103.1803
> > >
> > > I'll going to upgrade the bios.
> > >
> > > Processor type: Intel (R) Pentium(R) D CPU 2.80GHz
> > > Intel (R) EM64T Capable.
> > >
> > > Using 512MB of DDR2 Dual Channel,
> > > ASL0 256MB
> > > ASL1 Not Installed
> > > BSL0 256MB
> > > BSL1 Not Installed
> 
> -- 
> Gustavo Guillermo Pérez
> Compunauta uLinux
> www.compunauta.com

---
~Randy
