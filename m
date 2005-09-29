Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVI2Vny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVI2Vny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVI2Vny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:43:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4298 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030255AbVI2Vnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:43:51 -0400
Date: Thu, 29 Sep 2005 23:43:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with CF bluetooth
Message-ID: <20050929214340.GB2180@elf.ucw.cz>
References: <20050929134802.GA6042@elf.ucw.cz> <1128008752.5123.28.camel@localhost.localdomain> <20050929155602.GA1990@elf.ucw.cz> <1128011355.30743.14.camel@localhost.localdomain> <20050929175420.GN1990@elf.ucw.cz> <1128016693.6052.2.camel@localhost.localdomain> <20050929213219.GA2180@elf.ucw.cz> <20050929213707.GH7684@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929213707.GH7684@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I believe it would happen with any other CF card, too. Can you
> > > > hciattach it, unplug, hciattach again?
> > > 
> > > actually I don't have any of them with me and I don't saw a problem with
> > > my Casira of a serial port.
> > 
> > Following patch seems to work around it. And yes, printk() triggers
> > twice after 
> 
> What's the problem this patch is trying to address?

I get oops after starting my bluetooth subsystem for second
time. billionton_start, unplug CF, billionton_start will oops the
system. That patch prevents it.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
