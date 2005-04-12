Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVDLWmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVDLWmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVDLWjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:39:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:30139 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263002AbVDLWge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:36:34 -0400
Date: Tue, 12 Apr 2005 14:42:57 -0700
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412214256.GA18710@kroah.com>
References: <335DD0B75189FB428E5C32680089FB9F122163@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F122163@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 03:21:15PM -0500, Kilau, Scott wrote:
> 
> However, neither IBM nor Digi wants this thread's patch to be applied,
> and yet Christoph wants to do it, completely out of spite, to break our
> out-of-tree open source driver.
> 
> This is the problem that I have.

But that patch will enable the stock kernel.org kernel to work just fine
for that new device, right?  What is wrong with that for all of the
thousands of users of such kernels.  And if you want to provide a driver
that works with different features, there's no problem with that either.
We have numerous drivers in the stock kernel tree that work for the same
device, it's up to the distros to proper configure it in the manner they
so wish.

The patch does not "break" any other driver, they can both co-exist just
fine.

If you do object, please realize that this topic will come up again and
again and again as users try to patch the driver to work with the
device.  Also realize that people can do this dynamically through sysfs
today...

thanks,

greg k-h
