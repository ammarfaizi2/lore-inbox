Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbULPP7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbULPP7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULPP63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:58:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:52697 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261629AbULPP5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:57:18 -0500
Date: Thu, 16 Dec 2004 07:56:43 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Message-ID: <20041216155643.GB27421@kroah.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411171932.47163.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171932.47163.andrew@walrond.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 07:32:47PM +0000, Andrew Walrond wrote:
> I noticed that when upgrading from 2.6.8.1 to rc2, start_udev now takes 10-15s 
> after printing
> 
> "Creating initial udev device nodes:"

udevstart should be used instead of start_udev.  It goes a lot faster
and fixes odd startup dependancies that are needed.

> Any known reason? should I upgrade udev? (030 installed)

That's a very old version of udev.  049 is the current release.  Lots of
stuff has changed since then that might help you out :)

good luck,

greg k-h
