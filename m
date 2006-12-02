Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424119AbWLBQiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424119AbWLBQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 11:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163078AbWLBQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 11:38:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54289 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1163074AbWLBQiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 11:38:15 -0500
Date: Sat, 2 Dec 2006 12:52:35 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Lopez <dave.l.lopez@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add driver for LabJack USB DAQ devices
Message-ID: <20061202125235.GB4773@ucw.cz>
References: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: David Lopez <dave.l.lopez@gmail.com>
> 
> This driver adds support for LabJack U3 and UE9 USB DAQ 
> devices.

WTF is DAQ?

> +config USB_LJ
> +	tristate "USB LabJack DAQ devices driver"
> +	depends on USB
> +	help
> +	  USB driver for the following LabJack DAQ 
> devices:
> +	  - U3
> +	  - UE9


This is great place to explain...

> +	  For a user-space API and usage examples, please 
> visit the LabJack
> +	  downloads web page at 
> <http://www.labjack.com/downloads.php> and go
> +	  to the specific device's downloads page.

If it needs userland driver, anyway, why not libusb?
-- 
Thanks for all the (sleeping) penguins.
