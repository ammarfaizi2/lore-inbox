Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVGGAXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVGGAXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVGFT7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:62916 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262248AbVGFQ1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:27:23 -0400
Date: Wed, 6 Jul 2005 09:27:10 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
Message-ID: <20050706162710.GC13777@kroah.com>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <42CBA650.8080004@eyal.emu.id.au> <Pine.LNX.4.58.0507060837510.3570@g5.osdl.org> <20050706155103.GA13115@kroah.com> <Pine.LNX.4.58.0507060917530.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507060917530.3570@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 09:22:05AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 6 Jul 2005, Greg KH wrote:
> > 
> > --- gregkh-2.6.orig/sound/pci/bt87x.c	2005-07-06 08:48:29.000000000 -0700
> > +++ gregkh-2.6/sound/pci/bt87x.c	2005-07-06 08:48:54.000000000 -0700
> > @@ -798,6 +798,8 @@
> >  	{0x270f, 0xfc00}, /* Chaintech Digitop DST-1000 DVB-S */
> >  };
> >  
> > +static struct pci_driver driver;
> > +
> 
> Hmm.. Shouldn't you at a _minimum_ initialize the name and owner fields?

It's done so a few functions down.  This is just a "forward" reference
to the real thing there.

thanks,

greg k-h
