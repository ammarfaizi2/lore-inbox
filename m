Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUBTX5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUBTX5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:57:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:31211 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261435AbUBTX5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:57:06 -0500
Date: Fri, 20 Feb 2004 15:56:15 -0800
From: Greg KH <greg@kroah.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 018 release
Message-ID: <20040220235615.GA17875@kroah.com>
References: <20040219185932.GA10527@kroah.com> <20040219191315.GB10527@kroah.com> <200402201348.29745.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402201348.29745.mbuesch@freenet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 01:48:19PM +0100, Michael Buesch wrote:
> But I've a little issue left. My parallel port doesn't show
> up in /udev. I guess it's because of missing sysfs support?
> I'm running linux-2.6.3.
> I did not find an entry for the parallel port in sysfs.
> If I create the device node manually I can access lp.

Yes, that driver has not been converted to use sysfs yet.  It's on the
list of drivers to convert, only 162 more to go...  :(

thanks,

greg k-h
