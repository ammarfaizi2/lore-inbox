Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUBHQfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUBHQfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:35:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:21951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263823AbUBHQft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:35:49 -0500
Date: Sun, 8 Feb 2004 08:35:49 -0800
From: Greg KH <greg@kroah.com>
To: Mathieu LESNIAK <maverick@eskuel.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Kernel Oops
Message-ID: <20040208163549.GB2531@kroah.com>
References: <40261814.1020407@eskuel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40261814.1020407@eskuel.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 12:05:56PM +0100, Mathieu LESNIAK wrote:
> Hi !
> 
> I've got this kernel oops with 2.6.3-rc1 when I remove an usb 
> peripheral. The result is the same if USB UHCI is compiled statically or 
> in module.
> Please find in attachment the output of lspci and .config

The usbscanner driver is obsoleted, marked as broken, and removed
completely in the -mm tree and my usb tree.  Those changes will get sent
to Linus in a day or so.

In short, don't use this module, it's known to be broken and not needed.

thanks,

greg k-h
