Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUKVWa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUKVWa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbUKVW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:27:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36517 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262447AbUKVWZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:25:20 -0500
Date: Mon, 22 Nov 2004 14:13:04 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][0/12] Initial submission of InfiniBand patches for review
Message-ID: <20041122221304.GA15634@kroah.com>
References: <20041122713.Nh0zRPbm8qA0VBxj@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122713.Nh0zRPbm8qA0VBxj@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:13:24AM -0800, Roland Dreier wrote:
> organization of the code will be very much appreciated.  For example,
> the current set of patches puts include files in driver/infiniband/include;
> would it be preferred to put include files in include/linux/infiniband/,
> directly in include/linux, or perhaps in include/infiniband?

Who would be including these files, only drivers in drivers/infiniband?
Or from files in other parts of the kernel?

If from other parts of the kernel, use include/linux/infiniband.

thanks,

greg k-h
