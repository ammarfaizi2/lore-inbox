Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUCXTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUCXTV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:21:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:5067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263097AbUCXTVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:21:24 -0500
Date: Wed, 24 Mar 2004 11:18:25 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 Hotplugging
Message-ID: <20040324191825.GA24854@kroah.com>
References: <20040324181021.2d495742.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324181021.2d495742.Christoph.Pleger@uni-dortmund.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 06:10:21PM +0100, Christoph Pleger wrote:
> Hello,
> 
> I am using Kernel 2.6.4 and the newest hotplug software from
> ftp.kernel.org. When I hotplug a usb mass storage device, I get a
> message like "disk at
> /devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/host1/1:0:0:0" on
> tty1.
> 
> Where does this message come from and how can I prevent it from
> appearing? Of course I do not want such a message because it corrupts
> the text for example in the vi editor.

It's a bug in the current hotplug scripts.  Either back down to the
previous version (as the latest was only a development release), or wait
till I release a new version later this week.

Sorry about this.

greg k-h
