Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271143AbTGPWDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTGPWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:01:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:51688 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271146AbTGPWBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:01:20 -0400
Date: Wed, 16 Jul 2003 15:16:13 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Fredrik Tolf <fredrik@dolda2000.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Message-ID: <20030716221613.GA3067@kroah.com>
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307162323.31836.fredrik@dolda2000.cjb.net> <20030716215452.GB2773@kroah.com> <200307170007.04782.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307170007.04782.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 12:07:04AM +0200, Oliver Neukum wrote:
> 
> > > Huh? Look at it this way: As it is now, if you have a non-hotplug joystick, 
> > > then you can't load anything automatically, not even the hardware drivers.
> > 
> > Correct.
> > 
> > > If you have demand-loading in the input layer, on the other hand, you can have 
> > > "above" directives in modules.conf (or "install" directives in modprobe.conf) 
> > > to pull in the hardware drivers along with joydev.
> > 
> > Where do you get the hardware driver coming along with joydev?
> 
> By editing /etc/modules.conf

Ahh.  Hm, so you have to manually add each hardware driver to the file
to load when you want to open the joystick driver?  How 1990's :)

> > I must be missing something here...
> 
> Yes, there are non hotpluggable devices out there.
> It is easy to forget :-)

Heh, no, I remember.  I just forgot the modutils trick to do this,
sorry.

greg k-h
