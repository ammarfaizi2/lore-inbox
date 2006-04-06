Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWDFQaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWDFQaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDFQaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:30:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:47236 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751263AbWDFQa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:30:29 -0400
Date: Thu, 6 Apr 2006 09:26:36 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: stable@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [stable] [PATCH] isd200: limit to BLK_DEV_IDE
Message-ID: <20060406162636.GC5708@kroah.com>
References: <20060405120345.6ad380de.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405120345.6ad380de.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 12:03:45PM -0700, Randy.Dunlap wrote:
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Limit USB_STORAGE_ISD200 to whatever BLK_DEV_IDE and USB_STORAGE
> are set to (y, m) since isd200 calls ide_fix_driveid() in the
> BLK_DEV_IDE code.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/usb/storage/Kconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)

Queued to -stable, thanks.

greg k-h
