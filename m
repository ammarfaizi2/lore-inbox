Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263047AbVDLXOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVDLXOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVDLXOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:14:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:16330 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262968AbVDLXMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:12:52 -0400
Date: Tue, 12 Apr 2005 16:08:40 -0700
From: Greg KH <gregkh@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb: kfree cleanup for drivers/usb/* - no need to check for NULL
Message-ID: <20050412230840.GC21500@kroah.com>
References: <Pine.LNX.4.62.0504122211070.2572@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504122211070.2572@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:58:13PM +0200, Jesper Juhl wrote:
> Get rid of a bunch of redundant NULL pointer checks in drivers/usb/*, 
> there's no need to check a pointer for NULL before calling kfree() on it.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Applied, thanks.

greg k-h
