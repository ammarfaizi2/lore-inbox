Return-Path: <linux-kernel-owner+w=401wt.eu-S1030308AbXAKMlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbXAKMlN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbXAKMlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:41:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3434 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030308AbXAKMlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:41:12 -0500
Date: Wed, 10 Jan 2007 20:38:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.20-rc4: null pointer deref in khubd
Message-ID: <20070110203809.GA6378@ucw.cz>
References: <20070110104937.GA32112@elf.ucw.cz> <200701101653.57929.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701101653.57929.oneukum@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > usb 2-1: new full speed USB device using uhci_hcd and address 68
> > usb 2-1: USB disconnect, address 68
> > usb 2-1: unable to read config index 0 descriptor/start
> > usb 2-1: chopping to 0 config(s)
> 
> Does anybody know a legitimate reasons a device should have
> 0 configurations? Independent of the reason of this bug, should we disallow
> such devices and error out?

It is not bad device, btw, but extremely flakey connector. Bug is
random :-(, and machine is smp, so it might even be a race.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
