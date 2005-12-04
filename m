Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVLDAcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVLDAcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVLDAcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:32:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:15023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932189AbVLDAb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:31:59 -0500
Date: Sat, 3 Dec 2005 16:31:30 -0800
From: Greg KH <greg@kroah.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051204003130.GB1879@kroah.com>
References: <43923479.3020305@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43923479.3020305@tls.msk.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 03:12:41AM +0300, Michael Tokarev wrote:
> When I try to "standby" (echo standby > /sys/power/state)
> a 2.6.14 system running on a VIA C3-based system with VIA
> chipset (suspend to disk never worked on this system --
> as stated on swsusp website it's due to the lack of some
> CPU instruction on this CPU [but winXP suspends to disk
> on this system just fine]), it immediately comes back, with
> the above error message:

Can you try 2.6.15-rc4 or newer to see if that fixes this issue for you?

thanks,

greg k-h
