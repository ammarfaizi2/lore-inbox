Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTEWBaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTEWBaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:30:16 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:31651 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263570AbTEWBaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:30:15 -0400
Subject: Re: irtty_sir cannot be unloaded
From: Stian Jordet <liste@jordet.nu>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030523011349.GA12195@bougret.hpl.hp.com>
References: <20030522233609.GA11706@bougret.hpl.hp.com>
	 <1053652200.709.6.camel@chevrolet.hybel>
	 <20030523011349.GA12195@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1053654253.668.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 23 May 2003 03:44:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 23.05.2003 kl. 03.13 skrev Jean Tourrilhes:
> On Fri, May 23, 2003 at 03:10:00AM +0200, Stian Jordet wrote:
> > fre, 23.05.2003 kl. 01.36 skrev Jean Tourrilhes: 
> > > Stian Jordet wrote :
> > > > 
> > > > Module irtty_sir cannot be unloaded due to unsafe usage in
> > > > include/linux/module.h:456
> > > > 
> > > > I get this message when trying to use irda with 2.5.x. I know it has
> > > > been there for a long time, but since nothing happens
> > > 
> > > 	This is fixed in the patches I've send to Jeff :
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=105286597418927&w=2
> > > 	Just be patient ;-)
> > 
> > Well, this got rid of the warning :) But actually when I stop irattach
> > (using Debian's init-script (/etc/init.d/irda stop)) my computer
> > freezes. This works (of course) fine with 2.4.21-rc2. I thought the
> > problem was the module unloading, but it seems to be something with
> > irattach instead. Sorry about that.
> 
> 	Disable HotPlug in your kernel and recompile. Various network
> people have been notified of this bug, but this is not an easy one.

You were right, this was the problem. Then I just have to choose what I
need the most; irda or pcmcia :)

Thanks :)

Best regards,
Stian

