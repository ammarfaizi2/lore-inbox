Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVFAX7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVFAX7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFAX6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:58:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:40397 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261507AbVFAXwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:52:10 -0400
Date: Wed, 1 Jun 2005 17:02:28 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/3] RapidIO support: core
Message-ID: <20050602000228.GB5678@kroah.com>
References: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601110836.A16559@cox.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:08:36AM -0700, Matt Porter wrote:
> Patch is 108KB and can be found here:
> ftp://source.mvista.com/pub/rio/l26_rio_core.patch

register_driver() does not return the number of devices bound to the
driver.  So your comment in rio_register_driver() is incorrect.  Just
return count.

Hm, if the patch was inline it would be easier to comment on stuff like
this, I'll wait till then for the rest :)

thanks,

greg k-h
