Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbTHJQ11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTHJQ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:27:27 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:16541
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S269994AbTHJQ10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:27:26 -0400
Date: Sun, 10 Aug 2003 12:27:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: drivers/ide/setup-pci.c
Message-ID: <20030810162725.GA429@gtf.org>
References: <20030810120511.GA883@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810120511.GA883@kiwi.hjbaader.home>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 02:05:12PM +0200, Hans-Joachim Baader wrote:
> Hi!
> 
> drivers/ide/setup-pci.c ca. line 710:
> 
> if (noisy)
> 	printk(KERN_INFO "%s: not 100%% native mode: "
> 		"will probe irqs later\n", d->name);
> 
> The two %% will be printed as such at least on my system (i386, VGA console,
> no framebuffer):
> 
> AMD7411: not 100%% native mode:

hmmm, can you provide a dmesg output that shows this?

Using "%%" is quite standard, and produces only a single "%".

	Jeff



