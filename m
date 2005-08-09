Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVHIES7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVHIES7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVHIES7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:18:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:57987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932441AbVHIES7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:18:59 -0400
Date: Mon, 8 Aug 2005 21:11:33 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_find_device and pci_find_slot mark as deprecated
Message-ID: <20050809041133.GA10552@kroah.com>
References: <42F72D4D.8030102@volny.cz> <200508082354.j78Ns1Cn028468@wscnet.wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508082354.j78Ns1Cn028468@wscnet.wsc.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 01:54:01AM +0200, Jiri Slaby wrote:
> This marks these functions as deprecated not to use in latest drivers (it
> doesn't use reference counts and the device returned by it can disappear in
> any time).

Did you forget to send this to the PCI maintainer for some reason?

Anyway, no, I don't want these functions marked this way, it's only
going to cause build noise.  I'd much rather you, or others, send me
patches that remove the usage of these functions so I can just delete
them entirely.

thanks,

greg k-h
