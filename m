Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVLPXvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVLPXvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVLPXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:51:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:40071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964818AbVLPXuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:50:13 -0500
Date: Fri, 16 Dec 2005 15:17:52 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
Message-ID: <20051216231752.GA2731@kroah.com>
References: <20051214234016.0112a86e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214234016.0112a86e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:40:16PM -0800, Andrew Morton wrote:
>   Probably-unfixed bugs from -mm1 and -mm2 include:
> 
>   - "J.A. Magallon" <jamagallon@able.es>: usb_set_configuration() oops.

Now fixed in my tree.

>   - Rachita Kothiyal <rachita@in.ibm.com>: kexec fails during USB init

Fix is found, and will be in my tree soon.

>   - "Rafael J. Wysocki" <rjw@sisk.pl>: ehci_hcd crashes on load sometimes

Same fix as the previous one.

>   - Grant Coady <grant_lkml@dodo.com.au>: "Locked up on boot just after
>     USB 2.0 initialised, EHCI 1.00 ..."

Hopefully the same one as above.

>   - Martin Bligh <mbligh@google.com>: "Panics in pci_call_probe on both
>     x440 and NUMA-Q"

Unknown still.

thanks,

greg k-h
