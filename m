Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUDAPQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUDAPQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:16:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:29115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262406AbUDAPQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:16:31 -0500
Date: Thu, 1 Apr 2004 07:16:18 -0800
From: Greg KH <greg@kroah.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc3-mm4
Message-ID: <20040401151618.GA25910@kroah.com>
References: <20040401020512.0db54102.akpm@osdl.org> <200404011402.44875@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404011402.44875@WOLK>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 02:02:44PM +0200, Marc-Christian Petersen wrote:
> On Thursday 01 April 2004 12:05, Andrew Morton wrote:
> 
> Hi 
> 
> >  bk-usb.patch
> 
> hmm, did something changed in handling USB mice? starting with 2.6.5-rc3-mm1 
> and the included bk-usb.patch my USB mouse won't work anymore. Using 
> bk-usb.patch from 2.6.5-rc2-mm5 in 2.6.5-rc3-mm4 all works fine for me.
> 
> Attached are 2 files, one from 2.6.5-rc2-mm5 bk-usb and the other one is 
> 2.6.5-rc3-mm4 bk-usb. Seems the latter one does not proper init hid though 
> the module is loaded.

The hid.ko module was renamed to usbhid.ko.  Are you sure that you are
still loading the proper driver?  I don't see the messages:

> Apr  1 13:52:20 codeman kernel: usbcore: registered new driver hiddev
> Apr  1 13:52:20 codeman kernel: usbcore: registered new driver hid
> Apr  1 13:52:20 codeman kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver

In your second set of messages.

thanks,

greg k-h
