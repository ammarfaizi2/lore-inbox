Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbUJYM41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbUJYM41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUJYM41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:56:27 -0400
Received: from sd291.sivit.org ([194.146.225.122]:6075 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261797AbUJYM4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:56:14 -0400
Date: Mon, 25 Oct 2004 14:57:32 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Sonypi: use pci_get_device
Message-ID: <20041025125731.GG6027@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <200410210158.12014.dtor_core@ameritech.net> <200410210158.57064.dtor_core@ameritech.net> <200410210159.38252.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410210159.38252.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 01:59:35AM -0500, Dmitry Torokhov wrote:

> ChangeSet@1.1980, 2004-10-21 01:48:41-05:00, dtor_core@ameritech.net
>   Sonypi: switch from pci_find_device to pci_get_device.
[...]
> +	struct pci_dev *pcidev;
> +
> +	pcidev = pci_find_device(PCI_VENDOR_ID_INTEL,
> +				 PCI_DEVICE_ID_INTEL_82371AB_3,
> +				 NULL);

I guess this is supposed to be pci_get_device no ? :)

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
