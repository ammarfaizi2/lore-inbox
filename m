Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUASWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbUASWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:49:58 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:55823 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264359AbUASWtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:49:55 -0500
Date: Mon, 19 Jan 2004 22:49:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anton@samba.org
Subject: Re: [PATCH] ppc64: VIO support, from Dave Boutcher, Hollis Blanchard and Santiago Leon
Message-ID: <20040119224953.A7395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	anton@samba.org
References: <200401192200.i0JM0dtb006058@hera.kernel.org> <20040119223230.GA4885@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040119223230.GA4885@kroah.com>; from greg@kroah.com on Mon, Jan 19, 2004 at 02:32:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 02:32:30PM -0800, Greg KH wrote:
> Ick ick ick.  I thought you all were not going to add this function, but
> just use vio_register_driver() on it's own?  Loading a driver should not
> depend on CONFIG_HOTPLUG, as we now have different ways we can bind
> drivers to devices after they are loaded (see the new_id stuff for pci
> devices as an example.)

I wonder why this code got merged at all.  Half of it could easily be
scrapped by using the driver model properly.

