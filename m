Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTJQLTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTJQLTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:19:41 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:60383 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263402AbTJQLTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:19:39 -0400
Subject: Re: [Linux-fbdev-devel] FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1066389516.4777.231.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 13:18:36 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > --- linux-2.6.0-test7/drivers/video/radeonfb.c	Wed Oct 15 19:12:22 2003
> > +++ fbdev-2.6/drivers/video/radeonfb.c	Wed Oct 15 19:20:51 2003
> 
> drivers/video/radeonfb.c still exists, while the build system now uses the one
> in drivers/video/aty?

I haven't checked what James did here. In my tree, I was careful to keep
both old and new drivers available via 2 separate CONFIG options. 


