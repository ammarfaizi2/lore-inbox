Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbULEHwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbULEHwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbULEHwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:52:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:41160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261281AbULEHwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:52:20 -0500
Date: Sat, 4 Dec 2004 23:51:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: gandalf@wlug.westbo.se, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix ALSA resume
Message-Id: <20041204235155.3b8ad3fc.akpm@osdl.org>
In-Reply-To: <41B282F0.3020704@triplehelix.org>
References: <1102195391.1560.65.camel@tux.rsn.bth.se>
	<20041204172855.350100d0.akpm@osdl.org>
	<41B282F0.3020704@triplehelix.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <joshk@triplehelix.org> wrote:
>
> Andrew Morton wrote:
> > But Joshua crosses his heart and swears that the pci_disable_device() is
> > also needed for a successful swsusp resume.
> 
> I never said I had any problems with resuming.

OK, suspend was failing, yes?

> That said, I tried removing the pci_disable_device call and things seem
> to still work. So I guess it can be left out?

Can you please test Martin's patch?
