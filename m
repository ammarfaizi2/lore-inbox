Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUD1Txu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUD1Txu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUD1Tww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:52:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:23692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265055AbUD1SmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:42:09 -0400
Date: Wed, 28 Apr 2004 11:41:38 -0700
From: Greg KH <greg@kroah.com>
To: Sean Young <sean@mess.org>
Cc: Andrew Morton <akpm@osdl.org>, Chester <fitchett@phidgets.com>,
       Bryan Small <code_smith@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Message-ID: <20040428184138.GA17275@kroah.com>
References: <20040428181806.GA36322@atlantis.8hz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428181806.GA36322@atlantis.8hz.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 08:18:06PM +0200, Sean Young wrote:
> Here is a driver for the usb servo controllers from Phidgets 
> <http://www.phidgets.com/>, using sysfs. 
> 
> Note that the devices claim to be hid devices, so I've added them to the 
> hid_blacklist (HID_QUIRK_IGNORE). A servo controller isn't really an hid
> device (or is it?).
> 
> diff against 2.6.6-rc2.

Nice, I like tiny clean drivers like this :)

I've applied it to my trees, and it will make it into the next -mm tree,
and show up in the 2.6.7 release whenever it happens.

thanks,

greg k-h
