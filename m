Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVHIV75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVHIV75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVHIV75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:59:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:59323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964989AbVHIV74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:59:56 -0400
Date: Tue, 9 Aug 2005 14:57:37 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_find_device and pci_find_slot mark as deprecated
Message-ID: <20050809215737.GD22683@kroah.com>
References: <42F72D4D.8030102@volny.cz> <200508082354.j78Ns1Cn028468@wscnet.wsc.cz> <20050809041133.GA10552@kroah.com> <4af2d03a0508090258942f536@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af2d03a0508090258942f536@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:58:19AM +0200, Jiri Slaby wrote:
> On 8/9/05, Greg KH <greg@kroah.com> wrote:
> > On Tue, Aug 09, 2005 at 01:54:01AM +0200, Jiri Slaby wrote:
> > > This marks these functions as deprecated not to use in latest drivers (it
> > > doesn't use reference counts and the device returned by it can disappear in
> > > any time).
> > 
> > Did you forget to send this to the PCI maintainer for some reason?
> No, my badness, sorry.
> 
> > Anyway, no, I don't want these functions marked this way, it's only
> > going to cause build noise.  I'd much rather you, or others, send me
> > patches that remove the usage of these functions so I can just delete
> > them entirely.
> When the patch was here
> (http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_3.patch --
> it'll be certainly sliced into many pieces; of course I didn't cc you
> :(

Yes, I can't take anything so big.  Just break it up into pieces please.

thanks,

greg k-h
