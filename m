Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUEZEog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUEZEog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUEZEog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:44:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:62601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265147AbUEZEod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:44:33 -0400
Date: Tue, 25 May 2004 21:43:23 -0700
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-rc1] BUG: ibmasm doesn't compile
Message-ID: <20040526044323.GC22071@kroah.com>
References: <c901ne$4f9$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c901ne$4f9$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:08:35PM -0400, Bill Davidsen wrote:
> Actually the ibmasm driver (driver->misc->ibmasm) hasn't compiled in 
> some versions. However, it will compile as a module, so at the expecse 
> of having all the stuff to do modules you can use it. Given the size of 
> the machines which use that hardware, that's hardly an issue ;-) But not 
> compiling built-in indicates a problem.

What are the build errors?

> Does anyone know if there will be a driver for the current hardware? The 
> one in 2.6.recent can see an RSA-I card, but doesn't seem to speak to 
> the RSA-II card, which is required for security.

The RSA-II card is controlled by a userspace program which uses libusb
to talk to the device.  No kernel driver is needed.

thanks,

greg k-h
