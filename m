Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUDLWvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 18:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbUDLWvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 18:51:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:3490 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263151AbUDLWve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 18:51:34 -0400
Date: Mon, 12 Apr 2004 15:42:36 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Martin Hermanowski <martin@mh57.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-mm4 (hci_usb module unloading oops)
Message-ID: <20040412224236.GA24178@kroah.com>
References: <20040410200551.31866667.akpm@osdl.org> <20040412101911.GA3823@mh57.de> <20040412220353.GC23692@kroah.com> <1081809404.8634.24.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081809404.8634.24.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 12:36:45AM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > I get an oops when I try to unload the hci_usb module.
> > 
> > {sigh}  I'm hating that driver right now...
> > 
> > There are a number of pending bluetooth patches for that driver that fix
> > a number of different bugs, so I'm leary of trying to see if this is a
> > different one or not at this point in time.  Care to apply all of the
> > bluetooth patches and if this still happens, can you report it to the
> > linux-usb-devel and bluez-devel mailing lists?
> 
> about what pending Bluetooth patches are you talking? There is one from
> Alan in 2.6.5-mh3 that should fix this problem

That is the one I was referring to.

thanks,

greg k-h
