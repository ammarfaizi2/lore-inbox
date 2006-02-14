Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbWBNOAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbWBNOAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbWBNOAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:00:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32530 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030563AbWBNOAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:00:21 -0500
Date: Tue, 14 Feb 2006 15:00:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hansjoerg Lipp <hjlipp@web.de>,
       Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
Subject: 2.6.16-rc3-mm1: ISDN_DRV_GIGASET driver
Message-ID: <20060214140019.GD10701@stusta.de>
References: <20060214014157.59af972f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214014157.59af972f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc2-mm1:
>...
> +isdn4linux-siemens-gigaset-drivers-kconfigs-and-makefiles.patch
> +isdn4linux-siemens-gigaset-drivers-common-module.patch
> +isdn4linux-siemens-gigaset-drivers-event-layer.patch
> +isdn4linux-siemens-gigaset-drivers-isdn4linux-interface.patch
> +isdn4linux-siemens-gigaset-drivers-tty-interface.patch
> +isdn4linux-siemens-gigaset-drivers-procfs-interface.patch
> +isdn4linux-siemens-gigaset-drivers-direct-usb-connection.patch
> +isdn4linux-siemens-gigaset-drivers-isochronous-data-handler.patch
> +isdn4linux-siemens-gigaset-drivers-m105-usb-dect-adapter.patch
> 
>  New ISDN driver.
>...

I see two big problems with this driver:
- Do we really want to add new non-CAPI drivers to the kernel?
- A new driver that can only be built modular is not acceptable.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

