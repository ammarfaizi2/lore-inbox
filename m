Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVHIF7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVHIF7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVHIF7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:59:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:26278 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932358AbVHIF7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:59:49 -0400
Date: Mon, 8 Aug 2005 22:59:10 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] removes pci_find_device from i6300esb.c
Message-ID: <20050809055910.GB11457@kroah.com>
References: <42F73523.80205@gmail.com> <200508082355.j78NtGNS029681@wscnet.wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508082355.j78NtGNS029681@wscnet.wsc.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 01:55:16AM +0200, Jiri Slaby wrote:
> This patch changes pci_find_device to pci_get_device (encapsulated in
> for_each_pci_dev) in i6300esb watchdog card with appropriate adding pci_dev_put.

Can you please route all of these changes through me?  It's some tricky
code to get right, and lots of people have failed in the past, I don't
want this to be applied without lots of review.

So, care to resend all of your pci changes, including the documentation
ones, to me?

thanks,

greg k-h
