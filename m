Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265831AbUGTMzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUGTMzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUGTMzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:55:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43138 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265831AbUGTMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:54:59 -0400
Date: Tue, 20 Jul 2004 14:54:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Kotowicz <koto-lkml@mynetix.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend to disk breaks e100 driver kernel 2.6.7 and 2.6.8-rc1
Message-ID: <20040720125458.GC27492@atrey.karlin.mff.cuni.cz>
References: <1089641949.13037.5.camel@saturn.koto.lan> <20040716153527.GA8264@openzaurus.ucw.cz> <1090243759.12430.1.camel@saturn.koto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090243759.12430.1.camel@saturn.koto.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > whenever I put my notebook into suspend to disk by calling "echo -n disk
> > > > /sys/power/state" my network connection dies.
> > > this is what I get in the logs:
> > ...
> > ...
> > > taking the network connection down, removing the modules and reinserting
> > > it, doesn't help. I have to reboot the notebook for the network to work
> > > again.
> > > 
> > > this didn't happen with kernel 2.6.6 and prior versions.
> > 
> > Try copying e100 driver from 2.6.6 into recent kernel and/or try
> > using swsusp instead of pmdisk.
> 
> I'll do so.
> 
> Just for curiosity: is this rather a e100 or a pmdisk driver problem?
> will this be fixed in any upcoming kernel?

I do not have crystal ball here...

Try using swsusp instead of pmdisk, or get latest -mm where they are
merged.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
