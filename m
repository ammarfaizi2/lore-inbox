Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTJIWj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTJIWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:39:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:52365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262156AbTJIWj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:39:58 -0400
Date: Thu, 9 Oct 2003 14:28:04 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling static
Message-ID: <20031009212804.GD12618@kroah.com>
References: <1065708534.737.2.camel@chevrolet.hybel> <20031009210805.GB12266@kroah.com> <1065734600.6237.0.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065734600.6237.0.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 11:23:21PM +0200, Stian Jordet wrote:
> tor, 09.10.2003 kl. 23.08 skrev Greg KH:
> > On Thu, Oct 09, 2003 at 04:08:54PM +0200, Stian Jordet wrote:
> > > Hello,
> > > 
> > > when I try to rmmod the saa7134 module from kernel 2.6.0-test7, I get
> > > this call trace:
> > > 
> > > Device class 'i2c-1' does not have a release() function, it is broken
> > > and must be fixed.
> > 
> > This is when you remove the i2c-dev module, right?  Yeah, I know about
> > the problem and will fix it.
> 
> I have no idea, I just "rmmod saa7134" :)

Sorry, I ment to say, you have the i2c-dev module loaded, or built into
your kernel, right?  That will cause this warning to be printed out.

thanks,

greg k-h
