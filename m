Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVI2Q3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVI2Q3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVI2Q3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:29:09 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:50638 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932237AbVI2Q3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:29:07 -0400
Subject: Re: Problems with CF bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050929155602.GA1990@elf.ucw.cz>
References: <20050929134802.GA6042@elf.ucw.cz>
	 <1128008752.5123.28.camel@localhost.localdomain>
	 <20050929155602.GA1990@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 18:29:14 +0200
Message-Id: <1128011355.30743.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > > I have some problems with Billionton CF card: if I insert card,
> > > hciattach to it, eject it, hciattach again, I get an oops.
> > > 
> > > [Pretty recent kernel: Linux amd 2.6.14-rc2-g5fb2493e #106 Thu Sep 29
> > > 01:35:25 CEST 2005 i686 GNU/Linux]
> > > 
> > > Another problem is that... it works well on my PC. When I try to do
> > > the same hciattach on sharp zaurus handheld, I get
> > 
> > I am not an expert for the Zaurus, but the oops looks like a problem in
> > the serial subsystem. Does somebody else has seen problems with the
> > uart_flush_buffer() and other architectures?
> 
> No, oops is from normal PC. (And I believe it is reproducible). On
> zaurus, hciattach just fails (and I have no idea how to debug that :-(
> ).

I think that I have such a card at home, but I don't know when I have
time to pick it up. Anybody else out there to debug this.

Regards

Marcel


