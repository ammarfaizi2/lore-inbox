Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTLMAMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTLMAMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:12:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:28095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262048AbTLMAMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:12:33 -0500
Date: Fri, 12 Dec 2003 16:12:15 -0800
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031213001215.GA22390@kroah.com>
References: <20031210165540.B26394@fi.muni.cz> <20031210212807.GA8784@kroah.com> <1071105744.1154.1.camel@chevrolet.hybel> <1071114290.750.18.camel@chevrolet.hybel> <20031211064441.GA2529@kroah.com> <1071152620.753.1.camel@chevrolet.hybel> <1071154385.721.1.camel@chevrolet.hybel> <20031212211527.GC2002@kroah.com> <1071273888.1379.7.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071273888.1379.7.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 01:04:48AM +0100, Stian Jordet wrote:
> 
> Can my usb-serial converter be the flaky device, even though it's the
> Logitech that is complaining, or can it be the motherboard? Since I
> never-ever saw any error messages untill I recently switched my pl2303
> against the ftdi_sio.

The ftdi_sio device could be sucking more power than the pl2303 device
from the USB bus.  That's what I would guess is happening.

greg k-h
