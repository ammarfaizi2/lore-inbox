Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTFFRBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTFFRBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:01:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:55766 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262063AbTFFRBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:01:50 -0400
Date: Fri, 6 Jun 2003 10:17:00 -0700
From: Greg KH <greg@kroah.com>
To: Joe Thornber <thornber@sistina.com>
Cc: dm-devel@sistina.com, Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] device-mapper ioctl interface
Message-ID: <20030606171700.GC12231@kroah.com>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605093943.GD434@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:39:43AM +0100, Joe Thornber wrote:
> Here's the header file for the the proposed new ioctl interface for
> dm.  We've tried to change as little as possible to minimise code
> changes in LVM2 and EVMS.

Minor comment:
	- please do not use uint_32t types in kernel header files.  Use
	  the proper __u32 type which is guarenteed to be the proper
	  size across the user/kernel boundry.

thanks,

greg k-h
