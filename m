Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUKRSxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUKRSxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUKRSwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:52:04 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:736 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262883AbUKRSuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:50:21 -0500
Date: Thu, 18 Nov 2004 10:50:11 -0800
From: Greg KH <greg@kroah.com>
To: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
Message-ID: <20041118185011.GA24538@kroah.com>
References: <200411181859.27722.gjwucherpfennig@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411181859.27722.gjwucherpfennig@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 06:59:27PM +0100, Gerold J. Wucherpfennig wrote:
> 
> - Make sysfs optional and enable to publish kernel <-> userspace data
> especially the kernel's KObject data across the kernel's netlink interface as
> it has been summarized on www.kerneltrap.org. This will avoid the
> deadlocks sysfs does introduce when some userspace app holds an open file
> handle of an sysfs object (KObject) which is to be removed. An importrant side 
> effect for embedded systems will be that the RAM overhead introduced by sysfs
> will vaporize.

What RAM overhead?  With 2.6.10-rc2 the memory footprint of sysfs has
been drasticly shrunk.

What deadlocks are you referring to?

And the netlink interface for hotplug events is already present in the
latest kernel.

thanks,

greg k-h
