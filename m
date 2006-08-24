Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWHXGbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWHXGbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWHXGbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:31:08 -0400
Received: from natblert.rzone.de ([81.169.145.181]:33448 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1030334AbWHXGbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:31:07 -0400
Date: Thu, 24 Aug 2006 08:29:43 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.11
Message-ID: <20060824062943.GA11477@aepfle.de>
References: <20060823213108.GA12308@kroah.com> <20060823213130.GB12308@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060823213130.GB12308@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, Greg KH wrote:

> +++ b/drivers/serial/Kconfig
> @@ -803,6 +803,7 @@ config SERIAL_MPC52xx
>  	tristate "Freescale MPC52xx family PSC serial support"
>  	depends on PPC_MPC52xx
>  	select SERIAL_CORE
> +	select FW_LOADER
>  	help
>  	  This drivers support the MPC52xx PSC serial ports. If you would
>  	  like to use them, you must answer Y or M to this option. Not that

This was for SERIAL_ICOM
