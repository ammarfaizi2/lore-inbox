Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUD2DJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUD2DJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUD2DJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:09:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:16553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261880AbUD2DJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:09:35 -0400
Date: Wed, 28 Apr 2004 20:08:24 -0700
From: Greg KH <greg@kroah.com>
To: Sean Young <sean@mess.org>
Cc: Chester <fitchett@phidgets.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Message-ID: <20040429030824.GA4397@kroah.com>
References: <20040428181806.GA36322@atlantis.8hz.com> <20040428184138.GA17275@kroah.com> <20040429015951.GA4135@behemoth.pad.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429015951.GA4135@behemoth.pad.mess.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 03:59:51AM +0200, Sean Young wrote:
> On Wed, Apr 28, 2004 at 11:41:38AM -0700, Greg KH wrote:
> > On Wed, Apr 28, 2004 at 08:18:06PM +0200, Sean Young wrote:
> > > Here is a driver for the usb servo controllers from Phidgets 
> > > <http://www.phidgets.com/>, using sysfs. 
> > > 
> > > Note that the devices claim to be hid devices, so I've added them to the 
> > > hid_blacklist (HID_QUIRK_IGNORE). A servo controller isn't really an hid
> > > device (or is it?).
> > > 
> > > diff against 2.6.6-rc2.
> > 
> > Nice, I like tiny clean drivers like this :)
> > 
> > I've applied it to my trees, and it will make it into the next -mm tree,
> > and show up in the 2.6.7 release whenever it happens.
> 
> Great! Thanks.
> 
> Somehow I managed to send the wrong version. Here is a patch which fixes
> that. (Remove a dev_info() which wasn't supposed to be there, and make sure 
> that everything is still consistent in the unlikely event that kmalloc()
> fails). Just minor cleanups.

Heh, that happens :)

Applied, thanks.

greg k-h
