Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVJUA1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVJUA1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVJUA1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:27:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:52166 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964814AbVJUA1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:27:04 -0400
Date: Thu, 20 Oct 2005 17:26:31 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Mayer <jonmayer@google.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] added sysdev attribute to sysdev show/store methods - for linux-2.6.13.4
Message-ID: <20051021002631.GA18404@kroah.com>
References: <4a45da430510201447r2970ea67rfac8dffe7223a68@mail.google.com> <d120d5000510201459y25a2c8e5v55bf830c445c9dbf@mail.gmail.com> <4a45da430510201503v74874acoca37bba3aa5a2d07@mail.google.com> <d120d5000510201603n50c068dcyade2ce2cfd2311e0@mail.gmail.com> <4a45da430510201607x78c5e432r5d641c46dd15eeaa@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a45da430510201607x78c5e432r5d641c46dd15eeaa@mail.google.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 04:07:59PM -0700, Jonathan Mayer wrote:
> > If it is a device it goes onto corresponding bus. Platform bus is a
> > kind of a kitchen sink for things that do not have a "real" bus -
> > things like keyboard controller, older ISA devices, etc. Only things
> > that necessary to get the box going and have to be suspended last with
> > interrupts off (like IRQ controller) should be implemented as system
> > devices.
> 
> I see!  Okay, I will make this so.  Thanks for the explanation.
> 
> Even so, I still think my patch is a good idea (for the sysdev
> attributes, and all kobject attribute derived thingies in general).

It is a good idea, if someone needs access to that attribute
information.  But for now, no one does.  When they do, I'll be glad to
accept the patch.

Oh, and Pat isn't the driver core maintainer anymore...

thanks,

greg k-h
