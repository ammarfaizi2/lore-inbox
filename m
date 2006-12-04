Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759709AbWLDIgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759709AbWLDIgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759698AbWLDIgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:36:18 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:42695 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1759189AbWLDIgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:36:16 -0500
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.19
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0612032320470.28502@twin.jikos.cz>
References: <Pine.LNX.4.44L0.0612021555530.20254-100000@netrider.rowland.org>
	 <1165151160.19590.2.camel@localhost>
	 <Pine.LNX.4.64.0612032320470.28502@twin.jikos.cz>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 09:35:35 +0100
Message-Id: <1165221335.12640.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> > about the USBHID part. Jiri Kosina is just about to finally split the 
> > HID parser and make it available for Bluetooth and USB as an independent 
> > subsystem. This might conflict with any autosuspend changes for the 
> > USBHID. It might be better that this waits until Jiri's patches are 
> > merged.
> 
> Yup, thanks, I think so.
> 
> Just for the record - I am planning to push these patches just after 
> 2.6.20-rc1 either to Andrew or Greg.

I think we can go directly after any pending input subsystem patches
have been merged.

However we need a clean Git tree to make sure that the moving and
renaming preserves the revision history of the USB HID driver. If you
don't have a kernel.org account by now, then it is time to get one.

Regards

Marcel


