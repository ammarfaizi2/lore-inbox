Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265924AbUAFXJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265952AbUAFXJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:09:36 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:55441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265924AbUAFXJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:09:35 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] VT locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <20040106140002.6806757b.akpm@osdl.org>
References: <1073349182.9504.175.camel@gaston>
	 <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
	 <1073425440.773.10.camel@gaston>  <20040106140002.6806757b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1073430528.4067.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 10:08:49 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's OK, it's just in there for a soak-test at present - this stuff is
> quite a long way away, yes?

The VT locking on the debug crude hack ? :)

Well it depends :) If nobody complains, it could get in pretty fast :)
In any case, please report me any trigger of the WARN_ON... I didn't
chield everything yet with the console sem, so there may still be
some of them coming from the low level code.

> It's probably just easiest for you to work against current -bk, send me a
> single rolled up patch whenever you have new things for people to test. 
> When we're happy with it all we can do a bk merge of everything.

Ok.


