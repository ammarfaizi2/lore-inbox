Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWHUBjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWHUBjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 21:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWHUBjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 21:39:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:18912 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751800AbWHUBjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 21:39:19 -0400
Date: Sun, 20 Aug 2006 18:35:45 -0700
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jwboyer@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       linux-mtd <linux-mtd@lists.infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.6.18-rc4 jffs2 problems
Message-ID: <20060821013545.GA21012@kroah.com>
References: <1154976111.17725.8.camel@localhost.localdomain> <1155852587.5530.30.camel@localhost.localdomain> <625fc13d0608191834r19ce12e5raccbae011d67c25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0608191834r19ce12e5raccbae011d67c25e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 08:34:46PM -0500, Josh Boyer wrote:
> On 8/17/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> >Read the return value before we release the nand device otherwise the
> >value can become corrupted by another user of chip->ops, ultimately
> >resulting in filesystem corruption.
> >
> 
> We have multiple confirmations that this patch fixes the issue
> reported.  I agree it should go in 2.6.18.
> 
> Greg, can you add this to your tree?

Add what to what tree?  I need things to be a bit more specific here :)

thanks,

greg k-h
