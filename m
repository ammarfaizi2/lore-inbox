Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbUADEcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 23:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUADEcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 23:32:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:41359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265119AbUADEcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 23:32:05 -0500
Date: Sat, 3 Jan 2004 20:30:37 -0800
From: Greg KH <greg@kroah.com>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1, scanner.ko, oops
Message-ID: <20040104043037.GA24110@kroah.com>
References: <20040103183501.GA2906@butterfly.hjsoft.com> <20040103225154.GK11061@kroah.com> <20040104035748.GA30429@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104035748.GA30429@butterfly.hjsoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 10:57:49PM -0500, John M Flinchbaugh wrote:
> On Sat, Jan 03, 2004 at 02:51:54PM -0800, Greg KH wrote:
> > On Sat, Jan 03, 2004 at 01:35:01PM -0500, John M Flinchbaugh wrote:
> > > i tried my canoscan 670u scanner with 2.6.1-rc1's scanner module,
> > > xsane 0.91, sane 1.0.13.  (also, i'm using ohci-hcd on a tyan
> > > thunder s2462ung.)
> > Can you try not using the scanner module?  xsane should work just fine
> > using libusb, talking to the device from userspace with no kernel
> > module.
> 
> it does indeed work using libusb.  i had gotten the impression
> that the scanner module may not be the preferred path these
> days.  is this correct?

See the help text for CONFIG_USB_SCANNER :)

thanks,

greg k-h
