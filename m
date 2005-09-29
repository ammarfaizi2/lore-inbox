Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVI2Rya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVI2Rya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVI2Rya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:54:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932287AbVI2Rya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:54:30 -0400
Date: Thu, 29 Sep 2005 19:54:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with CF bluetooth
Message-ID: <20050929175420.GN1990@elf.ucw.cz>
References: <20050929134802.GA6042@elf.ucw.cz> <1128008752.5123.28.camel@localhost.localdomain> <20050929155602.GA1990@elf.ucw.cz> <1128011355.30743.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128011355.30743.14.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I have some problems with Billionton CF card: if I insert card,
> > > > hciattach to it, eject it, hciattach again, I get an oops.
> > > > 
> > > > [Pretty recent kernel: Linux amd 2.6.14-rc2-g5fb2493e #106 Thu Sep 29
> > > > 01:35:25 CEST 2005 i686 GNU/Linux]
> > > > 
> > > > Another problem is that... it works well on my PC. When I try to do
> > > > the same hciattach on sharp zaurus handheld, I get
> > > 
> > > I am not an expert for the Zaurus, but the oops looks like a problem in
> > > the serial subsystem. Does somebody else has seen problems with the
> > > uart_flush_buffer() and other architectures?
> > 
> > No, oops is from normal PC. (And I believe it is reproducible). On
> > zaurus, hciattach just fails (and I have no idea how to debug that :-(
> > ).
> 
> I think that I have such a card at home, but I don't know when I have
> time to pick it up. Anybody else out there to debug this.

I believe it would happen with any other CF card, too. Can you
hciattach it, unplug, hciattach again?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
