Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbTIDSMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbTIDSMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:12:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:16608 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265432AbTIDSMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:12:45 -0400
Date: Thu, 4 Sep 2003 10:55:23 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 4 and USB
Message-ID: <20030904175523.GA10637@kroah.com>
References: <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com> <3F564EAE.20805@nanovoid.com> <6usmndqv48.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6usmndqv48.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:01:59AM +0100, Sean Neakums wrote:
> "Blake B." <shadoi@nanovoid.com> writes:
> 
> > Hmm... once I mounted the usbfs, and had the proper modules loaded
> > (uhci-usb, etc...) /proc/bus/usb was populated.
> 
> "usbdevfs", which is provided by the usbcore module (maybe usb-core)

"usbfs" == "usbdevfs"

The "usbdevfs" name will be going away in 2.7 so I encourage you to use
"usbfs" starting now (it also works in 2.4.)

thanks,

greg k-h
