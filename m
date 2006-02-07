Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWBGA1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWBGA1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBGA1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:27:37 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17118
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932313AbWBGA1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:27:36 -0500
Date: Mon, 6 Feb 2006 16:27:49 -0800
From: Greg KH <greg@kroah.com>
To: "Fr?d?ric L. W. Meunier" <2@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What causes "USB disconnect" ?
Message-ID: <20060207002749.GA6774@kroah.com>
References: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 10:15:11PM -0200, Fr?d?ric L. W. Meunier wrote:
> I never got this messages since I started using 2.6. Today I 
> got it in 2.6.16-rc2. Is this a problem in this version ? How 
> to determine ? I wasn't using the device.
> 
> Feb  6 20:49:48 pervalidus kernel: usb 1-2: USB disconnect, address 4

The device went away.

> Feb  6 21:01:03 pervalidus kernel: usb 1-2: new low speed USB device using uhci_hcd and address 5

10 minutes later it came back.

Did you bump the cable?

It it still working ok?

Did it go into "suspend" mode and just power down, and then later come
back when you touch it (like a mouse)?

thanks,

greg k-h
