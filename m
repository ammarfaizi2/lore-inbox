Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266597AbUGPRSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUGPRSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266601AbUGPRSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:18:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:9433 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266597AbUGPRSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:18:38 -0400
Date: Fri, 16 Jul 2004 10:17:03 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
Message-ID: <20040716171702.GA10598@kroah.com>
References: <10898500322333@kroah.com> <10898500321009@kroah.com> <20040716170716.GD8264@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716170716.GD8264@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 07:07:16PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +menu "Dallas's 1-wire bus"
> > +
> > +config W1
> > +	tristate "Dallas's 1-wire support"
> > +	---help---
> > +	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
> > +	  such as iButtons and thermal sensors.
> 
> Just out of curiosity... are such devices really connected using one wire only,
> or is it GND+5V+one data wire, or GND+power&data wire?

I'm pretty sure it's just 1 wire, at least for the devices I've seen.

thanks,

greg k-h
