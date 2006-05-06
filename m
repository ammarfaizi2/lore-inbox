Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWEFGA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWEFGA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 02:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWEFGA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 02:00:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44191
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750857AbWEFGA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 02:00:57 -0400
Date: Fri, 05 May 2006 23:00:50 -0700 (PDT)
Message-Id: <20060505.230050.56609951.davem@davemloft.net>
To: greg@kroah.com
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netdev: create attribute_groups with
 class_device_add
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060506040839.GA12636@kroah.com>
References: <20060421125438.50f93a34@localhost.localdomain>
	<20060505.184158.131584956.davem@davemloft.net>
	<20060506040839.GA12636@kroah.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Fri, 5 May 2006 21:08:39 -0700

> On Fri, May 05, 2006 at 06:41:58PM -0700, David S. Miller wrote:
> > From: Stephen Hemminger <shemminger@osdl.org>
> > Date: Fri, 21 Apr 2006 12:54:38 -0700
> > 
> > > Atomically create attributes when class device is added. This avoids the
> > > race between registering class_device (which generates hotplug event),
> > > and the creation of attribute groups.
> > > 
> > > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> > 
> > Did the first patch that adds the attribute_group creation
> > infrastructure go in so that we can get this networking fix in?
> 
> It and the netdev patch are setting in my tree which is showing up in
> -mm.  I'm going to wait until 2.6.17 is out to send the first patch.  I
> can send the second one then too if you want me to (probably make it
> easier that way.)

The networking bit by Stephen is a bug fix.
