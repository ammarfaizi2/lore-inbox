Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVC1UuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVC1UuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVC1UuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:50:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:32981 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262067AbVC1UrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:47:21 -0500
Date: Mon, 28 Mar 2005 12:44:12 -0800
From: Greg KH <greg@kroah.com>
To: Colin Leroy <colin@colino.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix shared key auth in zd1201
Message-ID: <20050328204411.GB3491@kroah.com>
References: <20050328114904.09291da8@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328114904.09291da8@jack.colino.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 11:49:04AM +0200, Colin Leroy wrote:
> Hi,
> 
> this is a resend of a patch that Andrew put in -mm, but that I think is
> ok and should go into mainline. I did not get any feedback (positive or
> negative) about it. Please either apply it or explain why not...
> 
> It's currently impossible to associate with a shared-key-only access
> point using the zd1201 driver. The attached patch fixes it. The reason
> was (probably) a typo in the definitions of the authentification types.
> I found that they should be (1,2) instead of (0,1) by looking at the
> old linux-wlan-ng driver by Zydas.

Applied, thanks.

greg k-h
