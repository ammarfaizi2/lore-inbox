Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbTGKWOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266899AbTGKWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:13:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:9198 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266799AbTGKWN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:13:29 -0400
Date: Fri, 11 Jul 2003 15:24:53 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711222453.GB23189@kroah.com>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:
> USB:
> ~~~~
> - Very little user visible changes, the only noticable 'major' change
>   is that there is now only one UHCI driver. As noted elsewhere, usbdevfs 
>   got renamed to usbfs.

The USB host controller drivers got renamed in 2.5.  They are now:
	uhci-hcd.o for UHCI USB host controllers
	ohci-hcd.o for OHCI USB host controllers
	ehci-hcd.o for EHCI (USB 2.0) host controllers

thanks,

greg k-h
