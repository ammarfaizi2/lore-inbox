Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWAaVAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWAaVAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWAaVAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:00:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:7841 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751482AbWAaVAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:00:30 -0500
Date: Tue, 31 Jan 2006 12:59:28 -0800
From: Greg KH <greg@kroah.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/11] LED: Add LED Class
Message-ID: <20060131205928.GA24349@kroah.com>
References: <1138714888.6869.125.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138714888.6869.125.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 01:41:28PM +0000, Richard Purdie wrote:
> +/**
> + * led_device_register - register a new object of led_device class.
> + * @dev: The device to register.
> + * @led_dev: the led_device structure for this device.
> + */
> +int led_device_register(struct device *dev, struct led_device *led_dev)

Shouldn't struct led_device contain a struct device within it, like the
rest of the driver model?

thanks,

greg k-h
