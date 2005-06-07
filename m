Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVFGPgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVFGPgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVFGP1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:27:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:20423 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261901AbVFGPB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:01:58 -0400
Date: Tue, 7 Jun 2005 08:01:30 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050607150130.GA14362@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3B0@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3B0@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 09:47:47AM -0500, Abhay_Salunke@Dell.com wrote:
> > Why not fix the firmware_class.c code now?  :)
> I am working on a solution for this; so yes, I will submit a patch to
> enhance firmware_class.c code.

Good.

> Mean while the driver sent earlier is tested and working on current
> version of 2.6 kernel and we have tested it with various distros based
> on 2.6 kernel. Changing the kernel and making the driver dependent on
> the new code will make the driver not work on the current kernels which
> the users have. 

Drivers are tightly bound to kernel versions.  Nothing new there.

> This will make driver non functional on current 2.6 kernels and will be
> an issue if users don't want to upgrade their kernels but just want the
> driver to update BIOS.

Then persuade the distros to accept your current version.  That's not
our issue :)

thanks,

greg k-h
