Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTLVXXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLVXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:23:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:8607 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264549AbTLVXW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:22:59 -0500
Date: Mon, 22 Dec 2003 15:22:50 -0800
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Message-ID: <20031222232250.GB4358@kroah.com>
References: <200312210137.41343.dtor_core@ameritech.net> <20031222230559.GE15612@ranty.pantax.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222230559.GE15612@ranty.pantax.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 12:05:59AM +0100, Manuel Estrada Sainz wrote:
> 
>  What can actually be a problem is that hotplug delays event handling
>  while booting, and if firmware needing drivers load at boot time they
>  usually timeout before the event gets handled, and when hotplug tryies
>  to handle the event the files are already gone.

What would remove the files?

And if you need firmware at boot time, stick it, and the firmware loader
in initramfs.

thanks,

greg k-h
