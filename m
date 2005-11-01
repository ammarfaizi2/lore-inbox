Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVKAU3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVKAU3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVKAU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:29:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:41384 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751128AbVKAU3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:29:41 -0500
Subject: Re: Would I be violating the GPL?
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: alex@alexfisher.me.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200511012000.21176.mbuesch@freenet.de>
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
	 <200511012000.21176.mbuesch@freenet.de>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:58:00 -0500
Message-Id: <1130875080.22089.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 20:00 +0100, Michael Buesch wrote:
> On Tuesday 01 November 2005 18:49, Alexander Fisher wrote:
> > Hello.
> > 
> > A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
> > driver as source code.  They have provided this code source with a
> > license stating I won't redistribute it in anyway.
> > My concern is that if I build this code into a module, I won't be able
> > to distribute it to customers without violating either the GPL (by not
> > distributing the source code), or the proprietary source code license
> > as currently imposed by the supplier.
> > From what I have read, this concern is only valid if the binary module
> > is considered to be a 'derived work' of the kernel.  The module source
> > directly includes the following kernel headers :
> 
> Take the code and write a specification for the device.
> Should be fairly easy.
> Someone else will pick up the spec and write a clean GPLed driver.

Seems excessive, why not just use a kernel debugger to capture all PIO
traffic to the device and write a driver based on that?

Lee

