Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWAJTwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWAJTwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJTwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:52:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:6018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932531AbWAJTwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:52:32 -0500
Date: Tue, 10 Jan 2006 11:51:53 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: Thinkpad docking station: pci hotplug questions
Message-ID: <20060110195153.GA17369@kroah.com>
References: <20060108191159.GA1880@elf.ucw.cz> <20060109035716.GB2824@kroah.com> <20060109151600.GE717@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109151600.GE717@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:16:00PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > I'm trying to get PCI hotplug to work on thinkpad x32 -- it is
> > > apparently neccessary for proper docking station support. What needs
> > > to be done to get it running?
> > > 
> > > I noticed some strangenesses:
> > > 
> > > pcihpfs is mentioned in Kconfig, but I can't find it anywhere in
> > > kernel
> > 
> > Yeah, that's 2.4 stuff, you don't need that anymore, everything shows up
> > in sysfs now.
> 
> Here's a fix. Where in sysfs should I find that?
> 
> root@amd:/sys# find . -name "*hot*"
> ./module/"pci_hotplug"

Look in /sys/bus/pci/slots/

thanks,

greg k-h
