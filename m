Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWHXHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWHXHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWHXHv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:51:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46525 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750807AbWHXHv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:51:57 -0400
Date: Thu, 24 Aug 2006 00:51:56 -0700
From: Greg KH <gregkh@suse.de>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.11
Message-ID: <20060824075156.GA6457@suse.de>
References: <20060823213108.GA12308@kroah.com> <20060823213130.GB12308@kroah.com> <20060824062943.GA11477@aepfle.de> <20060824071237.GA5577@suse.de> <20060824074041.GA12184@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824074041.GA12184@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 09:40:41AM +0200, Olaf Hering wrote:
> On Thu, Aug 24, Greg KH wrote:
> 
> > On Thu, Aug 24, 2006 at 08:29:43AM +0200, Olaf Hering wrote:
> > > On Wed, Aug 23, Greg KH wrote:
> > > 
> > > > +++ b/drivers/serial/Kconfig
> > > > @@ -803,6 +803,7 @@ config SERIAL_MPC52xx
> > > >  	tristate "Freescale MPC52xx family PSC serial support"
> > > >  	depends on PPC_MPC52xx
> > > >  	select SERIAL_CORE
> > > > +	select FW_LOADER
> > > >  	help
> > > >  	  This drivers support the MPC52xx PSC serial ports. If you would
> > > >  	  like to use them, you must answer Y or M to this option. Not that
> > > 
> > > This was for SERIAL_ICOM
> > 
> > What do you mean?  Is the patch wrong?
> 
> Yes, wrong place in the file, see http://lkml.org/lkml/2006/8/16/236

Ugh, how did patch go so wrong?

Anyway, care to send me a patch that I can use for the next -stable
release that fixes this up?

thanks,

greg k-h
