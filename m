Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVAXVmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVAXVmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVAXVjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:39:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:27332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261633AbVAXVh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:37:27 -0500
Date: Mon, 24 Jan 2005 13:34:42 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124213442.GC18933@kroah.com>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124175449.GK3515@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 06:54:49PM +0100, Adrian Bunk wrote:
> It seems noone who reviewed the SuperIO patches noticed that there are 
> now two modules "scx200" in the kernel...

Sorry about this.  Andrew warning me about this bug, and I saw it myself
with the depmod errors.  I'll take Evgeniy's patch for my tree and it
should show up in the next -mm release.

And as for the "these patches have never been reviewed" comments, that's
why I put them in my tree, and have them show up in -mm.  It's getting
them a wider exposure and finding out these kinds of issues.  So the
process is working properly :)

thanks,

greg k-h
