Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbTIPQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIPQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:59:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:26042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261980AbTIPQ7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:59:41 -0400
Date: Tue, 16 Sep 2003 09:49:41 -0700
From: Greg KH <greg@kroah.com>
To: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Ethernet cards
Message-ID: <20030916164941.GI3593@kroah.com>
References: <1b7201c37a73$844b7030$2dee4ca5@DIAMONDLX60> <20030914091702.B20889@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914091702.B20889@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 09:17:02AM +0100, Russell King wrote:
> On Sun, Sep 14, 2003 at 12:51:29PM +0900, Norman Diamond wrote:
> > Shutdown messages appear on the text console as follows:
> > [...]
> > Shutting down PCMCIA unregister_netdevice: waiting for eth0 to become free.
> > Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > unregister_netdevice: waiting for eth0 to become free. Usage count = 1
> > [...]
> > 
> > The only way to shut down at this point is to turn off the power.
> 
> IIRC the problem is your hotplug scripts.  Maybe the hotplug folk can tell
> you the minimum version for 2.6.

The last release version is the best for 2.6, but this doesn't look
like a hotplug script issue at all.

thanks,

greg k-h
