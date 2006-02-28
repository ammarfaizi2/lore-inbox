Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWB1A1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWB1A1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWB1A1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:27:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:22425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751843AbWB1A1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:27:11 -0500
Date: Mon, 27 Feb 2006 16:11:15 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>, Greg KH <gregkh@suse.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060228001115.GA22240@kroah.com>
References: <20060227190150.GA9121@kroah.com> <200602271952.08949.s0348365@sms.ed.ac.uk> <20060227195727.GA10752@suse.de> <200602272005.17470.s0348365@sms.ed.ac.uk> <20060227201214.GA12111@suse.de> <20060227201518.GA12262@kroah.com> <20060227225648.GB85023@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227225648.GB85023@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 11:56:48PM +0100, Olivier Galibert wrote:
> On Mon, Feb 27, 2006 at 12:15:18PM -0800, Greg KH wrote:
> > On Mon, Feb 27, 2006 at 12:12:14PM -0800, Greg KH wrote:
> > > On Mon, Feb 27, 2006 at 08:05:17PM +0000, Alistair John Strachan wrote:
> > > > But even now, devfs is still in the kernel.
> > > > 
> > > > Thanks for the answer anyway, I guess this is a non-issue (who will try to use 
> > > > code that can't be selected via config?).
> > > 
> > > Heh, true.  Actually, devfs is working in the kernel,
> > 
> > Oops, ment to say "is not working"...
> 
> It works at least enough for the basic devices, the block devices and
> ethernet to show up.

ethernet and networking never had anything to do with devfs.  And yes,
block devices do still work today.

thanks,

greg k-h
