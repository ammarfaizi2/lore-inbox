Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVATTyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVATTyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVATTxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:53:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:2463 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261921AbVATTwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:52:12 -0500
Date: Thu, 20 Jan 2005 11:50:58 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial8250_init and platform_device
Message-ID: <20050120195058.GA8835@kroah.com>
References: <20050120154420.D13242@flint.arm.linux.org.uk> <736677C2-6B16-11D9-BD44-000393DBC2E8@freescale.com> <20050120193845.H13242@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120193845.H13242@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 07:38:45PM +0000, Russell King wrote:
> 
> Greg - the name is constructed from "name" + "id num" thusly:
> 
> 	serial8250
> 	serial82500
> 	serial82501
> 	serial82502
> 
> When "name" ends in a number, it gets rather confusing.  Can we have
> an optional delimiter in there when we append the ID number, maybe
> something like a '.' or ':' ?

Sure, that's fine with me.  Someone send me a patch :)

thanks,

greg k-h
