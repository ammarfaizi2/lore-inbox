Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUILRKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUILRKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUILRKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:10:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:16852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268751AbUILRKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:10:09 -0400
Date: Sun, 12 Sep 2004 09:58:33 -0700
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev: udevd shall inform us abot trouble
Message-ID: <20040912165832.GA1161@kroah.com>
References: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua> <200409111943.21225.vda@port.imtp.ilyichevsk.odessa.ua> <41433A68.7090403@backtobasicsmgmt.com> <200409112122.36068.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409112122.36068.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 09:22:36PM +0300, Denis Vlasenko wrote:
> > The real solution here is for people to re-think their system startup
> > processes; if you need mixer settings applied at startup, then build a
> > small script somewhere in /etc/hotplug.d or /etc/dev.d that applies them
> > to the mixer _when it appears_.
> 
> As a user, I prefer to be able to use device right away after
> modprobe. Imagine ethN appearing "sometime after" modprobe.
> Would you like such behavior?

That happens today without udev with my usb wireless and ethernet
devices all the time.

See Kay's message for how this should be fixed up in userspace to work
properly.  It's what gentoo has switched over too, with much success.

thanks,

greg k-h
