Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTHaPlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTHaPlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:41:13 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:6027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262165AbTHaPlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:41:09 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-fbdev-users@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831140553.GC5106@pasky.ji.cz>
References: <20030831140553.GC5106@pasky.ji.cz>
Message-Id: <1062344399.32736.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 17:40:00 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Total radeonfb failure on both 2.6.0-test4 and 2.6.0-test4-mm4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   It appears that the 2.6 driver is essentially the old one, without Ben's
> patch (which fixed framebuffer for me on 2.4). Is there a version of this
> updated driver for 2.6 as well? Is there any reason why it is not integrated
> yet?

I'm working on a new driver for 2.6 that include my 2.4 updates, a
slightly reworked version of Kronos and Jon i2c DDC code and some
more source cleanup (split the driver in separate files actually).

It's not finished yet though. I'm not yet sure I'll add support for
dual head in the first version neither, all of this pretty much depends
on how much time I'll be able to dedicate to it during the upcoming
week.

Ben.


