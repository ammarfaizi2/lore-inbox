Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWGaTZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWGaTZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGaTZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:25:33 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:17426 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030347AbWGaTZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:25:30 -0400
Date: Mon, 31 Jul 2006 21:25:32 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-Id: <20060731212532.810a39f8.khali@linux-fr.org>
In-Reply-To: <200607310941.01340.david-b@pacbell.net>
References: <1154066134.13520.267064606@webmail.messagingengine.com>
	<200607310733.09125.david-b@pacbell.net>
	<20060731181327.d54ce1d0.khali@linux-fr.org>
	<200607310941.01340.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It doesn't work like this, sorry. The merge window for 2.6.18 is
> > closed. The driver needs to be reviewed before it is merged. So the
> > best you can hope for is -mm soon, and 2.6.19.
> 
> So there's been a change from the "new drivers can be merged late"
> policy?  News to me if so.  Not that this is a particularly new
> driver of course, or at all unstable.

This is my own policy for i2c drivers as the maintainer of the i2c
subsystem. I simply observed that new drivers cause much more late-rc
trouble than all other changes. So in order to let things stabilize
quickly, I don't take new drivers after -rc1. I see no reason why new
drivers would be allowed to bypass the -mm staging anyway.

If people want their drivers merged, they have to send them early. And
if they think I don't review them quickly enough (which is true) they
have to find other reviewers. There is no reason why I would have to
review every new i2c driver. As a matter of fact, I just don't have the
time to do so.

> > Indeed, this is no good. If you want things to improve, please help by
> > reviewing Komal's driver. I think I understand you already commented on
> > it, but I'd like you to really review it, and add a formal approval to
> > it (e.g. Signed-off-by or Acked-by). Then I'll review it for merge.
> 
> Review it again?  I'll try to make some time to help there, but
> it's unlikely I'll notice significant issues that seem to me
> worth holding up the upstream merge.  Certainly none that make
> up for the problems caused by having the kernel.org tree be all
> but unusable for OMAP work, and couldn't be patched later.

The "and could be patched later" way has been tried before, and I'm not
going there again. Later happened to be "never" or at least "too late"
more often than not.

And again maybe other subsystem maintainers have other policies, I
don't really care. I do the things the way I think works better. Anyone
not happy with that will have to help me a lot with the i2c patches
before I listen to him/her.

Thanks,
-- 
Jean Delvare
