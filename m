Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUCHXpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUCHXpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:45:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:49540 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261416AbUCHXoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:44:08 -0500
Date: Mon, 8 Mar 2004 14:49:34 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Andrew Morton <akpm@osdl.org>, Wim Van Sebroeck <wim@iguana.be>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1
Message-ID: <20040308224934.GA8387@kroah.com>
References: <20040307223221.0f2db02e.akpm@osdl.org> <200403082105.19328.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403082105.19328.thomas.schlichter@web.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 09:05:17PM +0100, Thomas Schlichter wrote:
> Hi,
> 
> the bk-usb.patch leads to following error:
> 
> drivers/char/watchdog/pcwd_usb.c: In function `usb_pcwd_probe':
> drivers/char/watchdog/pcwd_usb.c:592: error: structure has no member named 
> `act_altsetting'
> 
> The attached patch fixes it.

Yes, this is the proper fix, thanks.  It's already in my bk-usb tree
now.

greg k-h
