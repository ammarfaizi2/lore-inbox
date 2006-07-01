Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWGALjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWGALjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWGALjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:39:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50906 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964851AbWGALjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:39:44 -0400
Subject: Re: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL}
	{,un}register_die_notifier
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060630203546.93a7bd87.akpm@osdl.org>
References: <20060630113317.GV19712@stusta.de>
	 <20060630203546.93a7bd87.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 01 Jul 2006 12:54:08 +0100
Message-Id: <1151754849.7087.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 20:35 -0700, ysgrifennodd Andrew Morton:
> On Fri, 30 Jun 2006 13:33:17 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > -EXPORT_SYMBOL(register_die_notifier);
> > +EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
> > -EXPORT_SYMBOL(unregister_die_notifier);
> > +EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
> 
> I'd expect there are any number of low-level debugging quick-hacky modules
> around which want to hook into here.
> 
> We can try it I guess, but I expect we'll hear about it.

Some of the cluster modules use it too for fast failover.

Alan

