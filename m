Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWFIXRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWFIXRB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWFIXRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:17:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:7617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932587AbWFIXRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:17:00 -0400
Date: Fri, 9 Jun 2006 15:50:15 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Bock <o.bock@fh-wolfenbuettel.de>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Message-ID: <20060609225015.GE17807@kroah.com>
References: <200606082257.23286.o.bock@fh-wolfenbuettel.de> <20060609104541.GB16232@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609104541.GB16232@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 12:45:41PM +0200, Pavel Machek wrote:
> On ??t 08-06-06 22:57:18, Oliver Bock wrote:
> > From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
> > 
> > This is a new driver for the Cypress CY7C63xxx mirco controller series. It 
> > currently supports the pre-programmed CYC63001A-PC by AK Modul-Bus GmbH.
> > It's based on a kernel 2.4 driver (cyport) by Marcus Maul which I ported to kernel 2.6 
> > using sysfs. I intend to support more controllers of this family (and more features) as
> > soon as I get hold of the required IDs etc. Please see the source code's header for
> > more information.
> 
> I see "a" letters here tabs should have been. You probably need to
> resend...

It's just mime, my tools can handle it, I hope...

> > Please CC me as I'm not yet subscribed to LKML. Any comments are welcome.
> > Special thanks to Greg K-H for his helpful support!
> > 
> > diff against 2.6.16.19
> 
> Ugh, and new drivers should really go against 2.6.17-rcX.

Stand-alone drivers should work ok, I'll test this one and see...

thanks,

greg k-h
