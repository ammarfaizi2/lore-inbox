Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUFGWkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUFGWkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFGWkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:40:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:10200 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265114AbUFGWku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:40:50 -0400
Date: Mon, 7 Jun 2004 15:39:19 -0700
From: Greg KH <greg@kroah.com>
To: "Nemosoft Unv." <webcam@smcc.demon.nl>
Cc: kai.engert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: small patch: enable pwc usb camera driver
Message-ID: <20040607223919.GA9172@kroah.com>
References: <40C466FB.1040309@kuix.de> <20040607202036.GA6185@kroah.com> <200406080027.04577@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406080027.04577@smcc.demon.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 12:27:04AM +0200, Nemosoft Unv. wrote:
> On Monday 07 June 2004 22:20, Greg KH wrote:
> > On Mon, Jun 07, 2004 at 03:00:43PM +0200, Kai Engert wrote:
> > > The attached patch enables the pwc driver included with kernel
> > > 2.6.7-rc2
> > >
> > > It also removes the warnings during compilation.
> > > However, note that I blindly duplicated the release approach used by
> > > other usb camera drivers, replacing the current no-op.
> > >
> > > The driver works for me with a Logitech QuickCam Notebook Pro and
> > > GnomeMeeting.
> >
> > Nice, thanks, I've applied this.  
> 
> Don't use this. It will BUG() your kernel hard, because of a double free(). 

Oops, oh well, the pwc driver is really messed up then...
I already sent this to Linus, and as no one has fixed this issue up in a
long time, I'll wait for someone to send another patch fixing this
one as it's obvious that this driver does not have many users :(

> > It's amazing how long it took for this to be fixed... :(
> 
> I could start a big *bleep*ing rant about this, but I?ll save that for some 
> other time.

Heh, we've discussed this already in private, I'll be glad to discuss it
again, any time, in public on any mailing list.

thanks,

greg k-h
