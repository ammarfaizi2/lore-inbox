Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTDWUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTDWUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:02:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4767 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263570AbTDWUC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:02:26 -0400
Date: Wed, 23 Apr 2003 13:16:19 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: Nils Holland <nils@ravishing.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
Message-ID: <20030423201619.GB12889@kroah.com>
References: <3EA6C558.5040004@cox.net> <200304232134.42349.nils@ravishing.de> <3EA6EE47.4000801@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6EE47.4000801@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:49:27PM -0500, David van Hoose wrote:
> Nils Holland wrote:
> >On Wednesday 23 April 2003 18:54, David van Hoose wrote:
> >
> >
> >>I am running RedHat 9. Trackball is detected and works when using the
> >>stock 2.4.20-9 kernel that RedHat provided.
> >>
> >>With 2.4.21-rc1, I have included the USB and input devices in the
> >>kernel, as modules, and as various combinations in between. My USB
> >>Logitech Trackball shows up as being detected and setup, but it doesn't
> >>work.
> >
> >
> >I'm using a Logitech Cordless TrackMan here, and this works fine with 
> >2.4.21-rc1. I don't know which trackball you have, but the Logitech input 
> >devices all seem to be using more or less the same receiver, and this is 
> >what the problem would be about.
> >
> >Anyway, if not done already, I would suggest that you plug the trackball 
> >right into one of the computer's USB ports and not into an external hub to 
> >see if that makes a difference.
> 
> I have a Logitech Cordless Optical Trackman. It detects as a Logitech 
> Cordless Receiver. My motherboard is an Asus P4S8X. It has the 
> SiS648/SiS963 chipsets. I'm not using an external hub. I'm using the 
> ports on my motherboard. I've tried using all 6 USB ports I have, but I 
> get the same thing; detection and no input.

If you do not build in the CONFIG_USB_EHCI driver, does it work ok?

thanks,

greg k-h
