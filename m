Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbUKEEuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUKEEuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbUKEEuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:50:25 -0500
Received: from [211.58.254.17] ([211.58.254.17]:35016 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262598AbUKEEuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:50:21 -0500
Date: Fri, 5 Nov 2004 13:50:18 +0900
From: Tejun Heo <tj@home-tj.org>
To: Greg KH <greg@kroah.com>
Cc: rusty@rustcorp.com.au, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 0/4] driver-model: manual device attach
Message-ID: <20041105045018.GB25763@home-tj.org>
References: <20041104074330.GG25567@home-tj.org> <20041104175318.GH16389@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104175318.GH16389@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Greg,

On Thu, Nov 04, 2004 at 09:53:19AM -0800, Greg KH wrote:
> How does a device know what drivers could be bound to it?  It's the
> other way around, drivers know what kind of devices they can bind to.
> Let's add the ability to add more devices to a driver through sysfs,
> again, like PCI does.
> 
> > Writing a driver name attaches the device to the driver.
> 
> No, do it the other way, attach a driver to a device.

 Well, I just happen to think that devices attach to drivers as in
"attaching pci device 0000:00:08.0 to e1000 driver".  Maybe I'm just
weird. :-P

-- 
tejun

