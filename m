Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272461AbTGZLLf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 07:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272463AbTGZLLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 07:11:35 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:17116 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S272461AbTGZLLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 07:11:33 -0400
Date: Sat, 26 Jul 2003 13:26:36 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, willy@debian.org
Subject: Re: [PATCH] Re: Firmware loading problem
Message-ID: <20030726112636.GA31145@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <1058885139.2757.27.camel@pegasus> <20030722145546.GC23593@ranty.pantax.net> <1058888301.2755.8.camel@pegasus> <20030726090458.GA16634@ranty.pantax.net> <1059218065.2625.47.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059218065.2625.47.camel@pegasus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 01:14:17PM +0200, Marcel Holtmann wrote:
> Hi Manuel,
> 
> > > I tracked down the problem to request_firmware() or a sysfs problem.
> > > With the firmware included in a header file the driver itself works
> > > perfect.
> > 
> >  You are right, the problem was in sysfs, attached goes a patch that
> >  WorksForMe (tm), please test and report.
> 
> the firmware loading of my driver is now working, thanks. If someone has
> double checked the pci-sysfs.c change, please forward this patch to
> Linus.

 I'll wait for Greg and/or Matthew to say something about it.
 
> What did Marcelo say about including your backport into 2.4?

 Nothing, he didn't even bother to answer :-(. Maybe someone more
 relevant than myself could dig on the issue.

> > > Attached is a sample of how I use the request_firmware() and from the
> > > documentation it seems correct to me.
> > 
> >  Not what I was asking for, but it seams OK.
> 
> I know, but I don't have such an easy package you requested.

 Never mind, it is fixed now.

 Regards

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
