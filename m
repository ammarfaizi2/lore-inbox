Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWGALmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWGALmx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWGALmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:42:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21134 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932550AbWGALmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:42:52 -0400
Subject: Re: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL}
	{,un}register_die_notifier
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1151754849.7087.3.camel@localhost.localdomain>
References: <20060630113317.GV19712@stusta.de>
	 <20060630203546.93a7bd87.akpm@osdl.org>
	 <1151754849.7087.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 13:42:39 +0200
Message-Id: <1151754159.3195.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 12:54 +0100, Alan Cox wrote:
> Ar Gwe, 2006-06-30 am 20:35 -0700, ysgrifennodd Andrew Morton:
> > On Fri, 30 Jun 2006 13:33:17 +0200
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > -EXPORT_SYMBOL(register_die_notifier);
> > > +EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
> > > -EXPORT_SYMBOL(unregister_die_notifier);
> > > +EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */
> > 
> > I'd expect there are any number of low-level debugging quick-hacky modules
> > around which want to hook into here.
> > 
> > We can try it I guess, but I expect we'll hear about it.
> 
> Some of the cluster modules use it too for fast failover.

which ones?

the gfs ones are in -mm and aren't using it...


