Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVLFVPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVLFVPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVLFVPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:15:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:27076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030240AbVLFVPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:15:08 -0500
Date: Tue, 6 Dec 2005 13:14:23 -0800
From: Greg KH <greg@kroah.com>
To: herve@lucidia.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scanner/webcam not working when connected to USB hub
Message-ID: <20051206211423.GA5937@kroah.com>
References: <4413284c0512050519n67c50a88t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4413284c0512050519n67c50a88t@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 11:19:05AM -0200, Herv? Fache wrote:
> Hello guys,
> 
> I have the following problem: if connected directly to my computer's
> USB ports, my webcam works correctly, but when connected through my
> 'AirVast' hub (124a:168b), it fails. The device is reported by lsusb
> (IDs correct), but it does not work. The worst is: I have tried using
> some proprietary OS, and it all worked there.

Is it a USB 1.1 device connected to a USB 2.0 hub?  If so, Linux
currently has some issues with running properly for this setup.  See the
linux-usb-devel mailing list archives for some patches that some people
have found to resolve this.

thanks,

greg k-h
