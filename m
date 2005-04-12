Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVDLHls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVDLHls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVDLHls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:41:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:14227 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261758AbVDLHlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:41:47 -0400
Date: Tue, 12 Apr 2005 00:40:56 -0700
From: Greg KH <gregkh@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb: kfree() cleanups in drivers/usb/core/devio.c
Message-ID: <20050412074056.GD1371@kroah.com>
References: <Pine.LNX.4.62.0504112350160.2480@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504112350160.2480@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 11:55:22PM +0200, Jesper Juhl wrote:
> Checking for NULL before calling kfree() is redundant. This patch removes 
> these redundant checks and also makes a few tiny whitespace changes.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Applied, thanks.

greg k-h
