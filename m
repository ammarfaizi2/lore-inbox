Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUBRX1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266944AbUBRXZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:25:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:9377 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266681AbUBRXZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:25:04 -0500
Date: Wed, 18 Feb 2004 15:24:50 -0800
From: Greg KH <greg@kroah.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move CONFIG_HOTPLUG to kernel/Kconfig.hotplug
Message-ID: <20040218232450.GA6521@kroah.com>
References: <200402150157.05808.bzolnier@elka.pw.edu.pl> <20040216233911.GB23911@kroah.com> <200402170230.38839.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402170230.38839.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 02:30:38AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 17 of February 2004 00:39, Greg KH wrote:
> > On Sun, Feb 15, 2004 at 01:57:05AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > I've also noticed that some archs (cris, h8300, m68k and sparc) don't
> > > have HOTPLUG in their Kconfig files, shame on you - no udev for you 8).
> > >
> > > BTW maybe HOTPLUG should be moved from "Bus options" to "General setup"?
> >
> > I agree, it should go there, as it affects so much more these days than
> > "bus options".
> >
> > Care to make that change instead?
> 
> Done.  I put HOTPLUG between SYSCTL and IKCONFIG.
> 
> --bart
> 
> 
> [PATCH] move CONFIG_HOTPLUG to init/Kconfig
> 
> As a bonus: cris, h8300, m68k and sparc can use CONFIG_HOTPLUG now.

Looks good, I've applied this, thanks.

greg k-h
