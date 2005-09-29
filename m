Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVI2R6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVI2R6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVI2R6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:58:19 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:60622 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932289AbVI2R6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:58:19 -0400
Subject: Re: Problems with CF bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050929175420.GN1990@elf.ucw.cz>
References: <20050929134802.GA6042@elf.ucw.cz>
	 <1128008752.5123.28.camel@localhost.localdomain>
	 <20050929155602.GA1990@elf.ucw.cz>
	 <1128011355.30743.14.camel@localhost.localdomain>
	 <20050929175420.GN1990@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 19:58:13 +0200
Message-Id: <1128016693.6052.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > > > > I have some problems with Billionton CF card: if I insert card,
> > > > > hciattach to it, eject it, hciattach again, I get an oops.
> > > > > 
> > > > > [Pretty recent kernel: Linux amd 2.6.14-rc2-g5fb2493e #106 Thu Sep 29
> > > > > 01:35:25 CEST 2005 i686 GNU/Linux]
> > > > > 
> > > > > Another problem is that... it works well on my PC. When I try to do
> > > > > the same hciattach on sharp zaurus handheld, I get
> > > > 
> > > > I am not an expert for the Zaurus, but the oops looks like a problem in
> > > > the serial subsystem. Does somebody else has seen problems with the
> > > > uart_flush_buffer() and other architectures?
> > > 
> > > No, oops is from normal PC. (And I believe it is reproducible). On
> > > zaurus, hciattach just fails (and I have no idea how to debug that :-(
> > > ).
> > 
> > I think that I have such a card at home, but I don't know when I have
> > time to pick it up. Anybody else out there to debug this.
> 
> I believe it would happen with any other CF card, too. Can you
> hciattach it, unplug, hciattach again?

actually I don't have any of them with me and I don't saw a problem with
my Casira of a serial port.

Regards

Marcel


