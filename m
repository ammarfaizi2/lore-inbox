Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVAGRpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVAGRpB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVAGRoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:44:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50665 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261365AbVAGRn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:43:26 -0500
Date: Fri, 7 Jan 2005 09:43:29 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.10] ehci "hc died" on startup (chip bug workaround)
Message-ID: <20050107174328.GB28878@kroah.com>
References: <200501051435.42666.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501051435.42666.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 02:35:42PM -0800, David Brownell wrote:
> We seem to have tracked some annoying board-coupled EHCI startup
> problems to a chip bug, with a simple workaround.  Please merge.

Hm, I get a reject from this:
drivers/usb/host/ehci-hcd.c 1.153: 1210 lines
patching file drivers/usb/host/ehci-hcd.c
Hunk #1 FAILED at 903.
1 out of 1 hunk FAILED -- saving rejects to file drivers/usb/host/ehci-hcd.c.rej

What kernel tree is it against?

thanks,

greg k-h
