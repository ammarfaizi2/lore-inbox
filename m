Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVC1XWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVC1XWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVC1XWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:22:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:3275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262108AbVC1XWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:22:17 -0500
Date: Mon, 28 Mar 2005 15:21:24 -0800
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI: remove pci_find_device usage from pci sysfs code.
Message-ID: <20050328232124.GA5265@kroah.com>
References: <11099696382684@kroah.com> <200503201554.05010.eike-kernel@sf-tec.de> <20050321184020.GA5472@kroah.com> <200503242206.12914.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503242206.12914.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 10:06:11PM +0100, Rolf Eike Beer wrote:
> Greg KH wrote:
> > On Sun, Mar 20, 2005 at 03:53:58PM +0100, Rolf Eike Beer wrote:
> > > Greg KH wrote:
> > > > ChangeSet 1.1998.11.23, 2005/02/25 08:26:11-08:00, gregkh@suse.de
> > > >
> > > > PCI: remove pci_find_device usage from pci sysfs code.
> 
> > > Any reasons why you are not using "for_each_pci_dev(pdev)" here?
> >
> > Nope, I forgot it was there :)
> 
> Patch is against 2.6.12-rc1-bk1 and does the same think like your one,
> except it uses for_each_pci_dev()

Applied, thanks.

greg k-h
