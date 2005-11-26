Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVKZU4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVKZU4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKZU4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:56:25 -0500
Received: from mx1.rowland.org ([192.131.102.7]:59662 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750736AbVKZU4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:56:25 -0500
Date: Sat, 26 Nov 2005 15:56:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <pavel@ucw.cz>, <shaohua.li@intel.com>, <akpm@osdl.org>
Subject: Re: 2.6.15-rc2-git5 continues to fail suspending (USB issue)
In-Reply-To: <4388C8C8.1050801@gmail.com>
Message-ID: <Pine.LNX.4.44L0.0511261552290.15477-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2005, Patrizio Bassi wrote:

> >Maybe it's a problem in the device.
> >
> >  
> >
> no..why should after resume?

How should I know?  It's _your_ device.  :-)

> however i remember some kernels ago (.13/.14) it worked
> after resume hotplug restarted my driver, now not.

To get some more useful information in the system log, turn on USB
debugging (CONFIG_USB_DEBUG) and enable usbcore's usbfs_snoop=Y module
parameter.

Alan Stern

