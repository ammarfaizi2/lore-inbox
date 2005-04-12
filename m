Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVDLIl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVDLIl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDLIl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:41:56 -0400
Received: from mail.dif.dk ([193.138.115.101]:63629 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262070AbVDLIkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:40:10 -0400
Date: Tue, 12 Apr 2005 10:40:08 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Thomas Sailer <sailer@ife.ee.ethz.ch>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb: kfree() cleanups in drivers/usb/core/devio.c
In-Reply-To: <20050412074056.GD1371@kroah.com>
Message-ID: <Pine.LNX.4.62.0504121037460.3879@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.62.0504112350160.2480@dragon.hyggekrogen.localhost>
 <20050412074056.GD1371@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Greg KH wrote:

> Date: Tue, 12 Apr 2005 00:40:56 -0700
> From: Greg KH <gregkh@suse.de>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: linux-kernel@vger.kernel.org, Thomas Sailer <sailer@ife.ee.ethz.ch>,
>     Greg Kroah-Hartman <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net
> Subject: Re: [PATCH] usb: kfree() cleanups in drivers/usb/core/devio.c
> 
> On Mon, Apr 11, 2005 at 11:55:22PM +0200, Jesper Juhl wrote:
> > Checking for NULL before calling kfree() is redundant. This patch removes 
> > these redundant checks and also makes a few tiny whitespace changes.
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> Applied, thanks.
> 
You're welcome. I have a patch 90% done that makes the same change for all 
of drivers/usb/* want me to send that along or would you prefer I stick to 
just drivers/usb/core/* ?  One huge patch OK or would you prefer it split 
into one patch pr modified file?   
I can send the patch later tonight when I get home from work.

-- 
Jesper Juhl

