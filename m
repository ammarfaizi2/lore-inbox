Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWHaU6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWHaU6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWHaU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:58:23 -0400
Received: from smtp8.orange.fr ([193.252.22.23]:26852 "EHLO
	smtp-msa-out08.orange.fr") by vger.kernel.org with ESMTP
	id S1750858AbWHaU6X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:58:23 -0400
X-ME-UUID: 20060831205821716.AED331C001C5@mwinf0809.orange.fr
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Xavier Bestel <xavier.bestel@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1157056749.4386.137.camel@mindpipe>
References: <20060830062338.GA10285@kroah.com>
	 <1157013027.7566.515.camel@capoeira>  <1157056749.4386.137.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 31 Aug 2006 22:58:54 +0200
Message-Id: <1157057934.24286.3.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 31 août 2006 à 16:39 -0400, Lee Revell a écrit :
> On Thu, 2006-08-31 at 10:30 +0200, Xavier Bestel wrote:
> > Hi Greg,
> > 
> > On Wed, 2006-08-30 at 08:23, Greg KH wrote:
> > [...]
> > > Thomas and I lamented that we were getting tired of seeing stuff like
> > > this, and it was about time that we added the proper code to the kernel
> > > to provide everything that would be needed in order to write PCI drivers
> > > in userspace in a sane manner.  Really all that is needed is a way to
> > > handle the interrupt, everything else can already be done in userspace
> > > (look at X for an example of this...)
> > [...]
> > > So, here's the code. 
> > 
> > I know I look like I'm trolling here, but as this is the perfect
> > stable-binary-driver-ABI some people have been looking for, it would be
> > wise to make it taint the kernel with its own flag.
> 
> Why?  There's no technical or legal requirement for userspace drivers to
> be GPLed.

Precisely. How do you know the bugreport you received isn't caused by
some weird binary userspace driver hosing the PCI bus ?

	Xav

