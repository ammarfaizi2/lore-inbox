Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUKLBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUKLBG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 20:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbUKLBG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 20:06:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20355 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262418AbUKLBGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 20:06:46 -0500
Date: Thu, 11 Nov 2004 16:56:24 -0800
From: Greg KH <greg@kroah.com>
To: Anthony Samsung <anthony.samsung@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network interface to driver and pci slot mapping
Message-ID: <20041112005624.GA12129@kroah.com>
References: <8874763604111113281b1cf9a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8874763604111113281b1cf9a5@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 04:28:35PM -0500, Anthony Samsung wrote:
> Given an interface name (like eth0), how do I determine:
> The name of the driver (module) for this interface.
> The PCI address for this interface, if relevant.

Use sysfs.  All of this information is there (well, the driver link back
to the module isn't there for most PCI drivers, but the functionality is
there if the drivers are modified to support it...)

thanks,

greg k-h
