Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVBXABl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVBXABl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVBWX6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:58:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:17056 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261727AbVBWXru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:47:50 -0500
Date: Wed, 23 Feb 2005 15:32:43 -0800
From: Greg KH <greg@kroah.com>
To: Telemaque Ndizihiwe <telendiz@eircom.net>
Cc: duncan.sands@free.fr, linux-usb-devel@lists.sourceforge.net,
       torvalds@osdl.org, akpm@osdl.org, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces (2 * HZ) with DATA_TIMEOUT in /drivers/usb/atm/speedtch.c
Message-ID: <20050223233243.GA6807@kroah.com>
References: <421CCE98.4090406@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421CCE98.4090406@eircom.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 06:42:32PM +0000, Telemaque Ndizihiwe wrote:
> This Patch replaces "(2 * HZ)" with "DATA_TIMEOUT" which is defined as
>     #define DATA_TIMEOUT (2 * HZ)
> in /drivers/usb/atm/speedtch.c in kernel 2.6.10.
> 
> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>

This has already been fixed in my tree, due to the change in time value
for the usb_bulk_msg() call.  See the latest -mm release to validate
this.

thanks,

greg k-h
