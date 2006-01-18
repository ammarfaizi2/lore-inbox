Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWARMOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWARMOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWARMOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:14:01 -0500
Received: from soohrt.org ([85.131.246.150]:24463 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S1030271AbWARMOB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:14:01 -0500
Date: Wed, 18 Jan 2006 13:13:59 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: udev/hotplug and automatic /dev node creation
Message-ID: <20060118121359.GC26895@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20060118024710.GB26895@quickstop.soohrt.org> <20060118040718.GA6579@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060118040718.GA6579@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Greg KH wrote:
> On Wed, Jan 18, 2006 at 03:47:10AM +0100, Horst Schirmeier wrote:
> > Hi,
> > 
> > I'm looking for documentation regarding how to write a Linux kernel
> > module that creates its own /dev node via udev/hotplug.
> > register_chrdev() and a simple udev/rules.d/ entry don't seem to be
> > sufficient...
> 
> Yes, register_chrdev() will do nothing for udev.
> 
> Take a look at the book, Linux Device Drivers, third edition (free
> online).  In the chapter about the driver model, there is a section
> about what udev needs.  The functions it says to use are no longer in
> the kernel, but it should point you in the right direction (hint, use
> class_device_create().)

Thank you very much, I'll look into this book and class_device_create().

> If you have a pointer to your code, I can probably knock out a patch for
> you very quickly.

I have no doubt you'll be able to do that, but my primary intention is
to dig into that myself :) thanks again.

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
