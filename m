Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbUCCPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUCCPaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:30:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:53919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262495AbUCCP1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:27:46 -0500
Date: Wed, 3 Mar 2004 07:27:40 -0800
From: Greg KH <greg@kroah.com>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] USB_GADGET depends on USB
Message-ID: <20040303152738.GH25687@kroah.com>
References: <20040303135756.GH7223@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303135756.GH7223@gruby.cs.net.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 02:57:56PM +0100, Jakub Bogusz wrote:
> Up to current cset it's possible to select USB_GADGET even if USB is
> disabled (causing only compilation errors). This patch adds depends
> rules to disallow USB_GADGET if USB is not enabled (similar to those
> found in other drivers/usb/*/Kconfig files).

But why would you want to do that?  You can have a box with USB gadget
support but not USB "host" support on it just fine.

This patch is not correct, nor needed.

thanks,

greg k-h
