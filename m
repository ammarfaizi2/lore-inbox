Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUDIRdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUDIRdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:33:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:38300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261505AbUDIRda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:33:30 -0400
Date: Fri, 9 Apr 2004 10:16:12 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Karsten Keil <kkeil@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ISDN Mailing List <isdn4linux@listserv.isdn4linux.de>
Subject: Re: [PATCH] Add sysfs class support for CAPI
Message-ID: <20040409171612.GA15820@kroah.com>
References: <1081516925.13202.8.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081516925.13202.8.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 03:22:05PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> here is a patch that adds class support to the ISDN CAPI module. Without
> it udev won't create the /dev/capi20 device node.

Looks good, but isn't there also a /dev/capi20.00 and so on device nodes
needed by this driver?  According to devices.txt those are valid
nodes...

thanks,

greg k-h
