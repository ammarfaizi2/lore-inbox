Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUCHXrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUCHXrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:47:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:15493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261417AbUCHXpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:45:06 -0500
Date: Mon, 8 Mar 2004 13:32:41 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, "James H. Cloos Jr." <cloos@jhcloos.com>
Subject: Re: evbug.ko
Message-ID: <20040308213241.GE16396@kroah.com>
References: <m3n06x4o0q.fsf@lugabout.jhcloos.org> <200403042238.13924.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403042238.13924.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 10:38:13PM -0500, Dmitry Torokhov wrote:
> On Wednesday 03 March 2004 04:30 pm, James H. Cloos Jr. wrote:
> > Any idea what might modprobe evbug.ko w/o operator intervention?
> > 
> 
> It's new hotplug scripts. Put modules you do not want to be automatically
> loaded even if they think they have hardware/facilities to bind to into
> /etc/hotplug/blacklist
> 
> I, for example, have evbug, joydev, tsdev and eth1394 there.
> 
> Greg, any chance adding evbug to the default version of hotplug package?

Care to send me a patch for it?

thanks,

greg k-h
