Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVEDE4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVEDE4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 00:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVEDE4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 00:56:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:12969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262019AbVEDE42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 00:56:28 -0400
Date: Tue, 3 May 2005 21:56:25 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with udev
Message-ID: <20050504045625.GA16474@kroah.com>
References: <20050503164318.3b4ba419.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503164318.3b4ba419.Christoph.Pleger@uni-dortmund.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 04:43:18PM +0200, Christoph Pleger wrote:
> Hello,
> 
> I have two problems with udev:
> 
> 1. When I use /dev as the root directory for udev, udev does not create
> the device nodes for my serial interfaces (/dev/ttyS0 etc.) although the
> necessary modules for serial device support are loaded. That prevented a
> program that I use to autodetect connected mouse devices from
> autodetecting a serial mouse.
> 
> 2. To solve the problem mentioned above, I now use /udev as the root
> directory for udev. When I now connect a USB stick to the computer, udev
> does not create the device nodes for the stick (/udev/uba etc.)
> 
> Does anybody know how to solve these problems?

Try providing your udev and kernel version, and the distro you are using
information to the linux-hotplug-devel mailing list.  That is the place
for udev questions like these.

thanks,

greg k-h
