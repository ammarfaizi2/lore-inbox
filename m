Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUAPBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUAPBF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:05:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:21961 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264339AbUAPBFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:05:23 -0500
Date: Thu, 15 Jan 2004 16:50:41 -0800
From: Greg KH <greg@kroah.com>
To: Brian McGroarty <brian@mcgroarty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB KVM breaks under 2.6.0
Message-ID: <20040116005041.GG23253@kroah.com>
References: <20040114064032.GA3247@mcgroarty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114064032.GA3247@mcgroarty.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 12:40:32AM -0600, Brian McGroarty wrote:
> I have a Belkin Omniview SE 4, a four port KVM, with keyboard and
> mouse provided to a Linux box via USB.
> 
> Under 2.4.23, the device works well. The keyboard and mouse are
> detected.
> 
> Under 2.6.0 (Debian build), the keyboard is not recognized.
> 
> I have verified that hid and usbkbd are loaded, and if I plug a USB
> keyboard directly into the machine, the keyboard is recognized
> properly.

NEVER use the usbkbd driver, unless you _really_ know what you are
doing.  Please read the config help entry for that item.

> /proc/bus/usb is empty -- with 2.4, I would have gone there to verify
> that the device was seen. Is there any data I can pull from 2.6 which
> might help diagnose this?

Did you mount usbfs there?

thanks,

greg k-h
