Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUGSN3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUGSN3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 09:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUGSN3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 09:29:23 -0400
Received: from charme.mynetix.de ([80.190.251.41]:58257 "EHLO
	charme.mynetix.de") by vger.kernel.org with ESMTP id S265232AbUGSN3V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 09:29:21 -0400
Subject: Re: suspend to disk breaks e100 driver kernel 2.6.7 and 2.6.8-rc1
From: Andreas Kotowicz <koto-lkml@mynetix.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040716153527.GA8264@openzaurus.ucw.cz>
References: <1089641949.13037.5.camel@saturn.koto.lan>
	 <20040716153527.GA8264@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1090243759.12430.1.camel@saturn.koto.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Jul 2004 15:29:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-16 at 17:35, Pavel Machek wrote:
> Hi!
> 
> > whenever I put my notebook into suspend to disk by calling "echo -n disk
> > > /sys/power/state" my network connection dies.
> > this is what I get in the logs:
> ...
> ...
> > taking the network connection down, removing the modules and reinserting
> > it, doesn't help. I have to reboot the notebook for the network to work
> > again.
> > 
> > this didn't happen with kernel 2.6.6 and prior versions.
> 
> Try copying e100 driver from 2.6.6 into recent kernel and/or try
> using swsusp instead of pmdisk.

I'll do so.

Just for curiosity: is this rather a e100 or a pmdisk driver problem?
will this be fixed in any upcoming kernel?

andreas

