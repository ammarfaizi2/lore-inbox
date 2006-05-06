Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWEFEK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWEFEK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 00:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWEFEK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 00:10:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:9660 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751139AbWEFEK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 00:10:26 -0400
Date: Fri, 5 May 2006 21:08:39 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netdev: create attribute_groups with class_device_add
Message-ID: <20060506040839.GA12636@kroah.com>
References: <20060421125255.3451959f@localhost.localdomain> <20060421125438.50f93a34@localhost.localdomain> <20060505.184158.131584956.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505.184158.131584956.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 06:41:58PM -0700, David S. Miller wrote:
> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 21 Apr 2006 12:54:38 -0700
> 
> > Atomically create attributes when class device is added. This avoids the
> > race between registering class_device (which generates hotplug event),
> > and the creation of attribute groups.
> > 
> > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> 
> Did the first patch that adds the attribute_group creation
> infrastructure go in so that we can get this networking fix in?

It and the netdev patch are setting in my tree which is showing up in
-mm.  I'm going to wait until 2.6.17 is out to send the first patch.  I
can send the second one then too if you want me to (probably make it
easier that way.)

thanks,

greg k-h
