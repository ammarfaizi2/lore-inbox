Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUK2TfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUK2TfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUK2TeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:34:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:6089 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261640AbUK2TKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:10:46 -0500
Date: Mon, 29 Nov 2004 11:07:20 -0800
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix unnecessary increment in firmware_class_hotplug()
Message-ID: <20041129190720.GB15452@kroah.com>
References: <20041125201935.213944c9.tokunaga.keiich@jp.fujitsu.com> <1101501024.6514.52.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101501024.6514.52.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 09:30:24PM +0100, Marcel Holtmann wrote:
> Hi Keiichiro,
> 
> >   This patch is to fix unnecessary increment of 'i' used to
> > specify an element of an arry 'envp[]' in firmware_class_hotplug().
> > The 'i' is already incremented in add_hotplug_env_var(), actually.
> 
> you are right. The incrementation is wrong, but it doesn't have any
> negative effect. However the same applies for the usb_hotplug() function
> in drivers/usb/core/usb.c.
> 
> > Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Applied, thanks.

greg k-h

