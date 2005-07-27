Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVG0Ujs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVG0Ujs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVG0Uhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:37:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:36564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262433AbVG0Uea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:34:30 -0400
Date: Wed, 27 Jul 2005 13:34:03 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 58/82] remove linux/version.h from drivers/usb
Message-ID: <20050727203403.GA3414@kroah.com>
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de> <20050710193606.58.Shahir3815.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050710193606.58.Shahir3815.2247.olh@nectarine.suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 07:36:06PM +0000, Olaf Hering wrote:
> 
> changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
> 
> remove code for obsolete kernels from drivers/usb/media/pwc/pwc-ctrl.c
> and drivers/usb/misc/sisusbvga/sisusb.h

This, and your other patches in this series, seem to have the leading
whitespace stripped off, making it very tough to apply.  Care to redo
them?

thanks,

greg k-h
