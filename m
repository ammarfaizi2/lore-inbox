Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWHaUjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWHaUjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHaUjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:39:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11231 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932346AbWHaUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:39:05 -0400
Subject: Re: [RFC] Simple userspace interface for PCI drivers
From: Lee Revell <rlrevell@joe-job.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1157013027.7566.515.camel@capoeira>
References: <20060830062338.GA10285@kroah.com>
	 <1157013027.7566.515.camel@capoeira>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 16:39:08 -0400
Message-Id: <1157056749.4386.137.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 10:30 +0200, Xavier Bestel wrote:
> Hi Greg,
> 
> On Wed, 2006-08-30 at 08:23, Greg KH wrote:
> [...]
> > Thomas and I lamented that we were getting tired of seeing stuff like
> > this, and it was about time that we added the proper code to the kernel
> > to provide everything that would be needed in order to write PCI drivers
> > in userspace in a sane manner.  Really all that is needed is a way to
> > handle the interrupt, everything else can already be done in userspace
> > (look at X for an example of this...)
> [...]
> > So, here's the code. 
> 
> I know I look like I'm trolling here, but as this is the perfect
> stable-binary-driver-ABI some people have been looking for, it would be
> wise to make it taint the kernel with its own flag.

Why?  There's no technical or legal requirement for userspace drivers to
be GPLed.

Lee

