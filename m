Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272063AbTHMX5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTHMXzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:55:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:22411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272053AbTHMXy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:54:58 -0400
Date: Wed, 13 Aug 2003 16:53:18 -0700
From: Greg KH <greg@kroah.com>
To: reg@dwf.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
Subject: Re: Linux 2.6.0-test3: USB still broken.
Message-ID: <20030813235318.GD7863@kroah.com>
References: <torvalds@osdl.org> <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org> <200308090749.h797n15Y001167@orion.dwf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308090749.h797n15Y001167@orion.dwf.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 01:49:01AM -0600, reg@dwf.com wrote:
> 
> The USB subsystem is still broken in test3.

Works for me :)

> everything seems to build w/o errors, but late in the boot the screen
> is filled with the line
> 
> 	drivers/usb/input/hid-core.c: control queue full
> 
> which repeats a a high rate and is VERY hard to break free from.
> Not good.

Can you tell the people on the linux-usb-devel mailing list about this,
and file a bug at bugzilla.kernel.org for it?

thanks,

greg k-h
