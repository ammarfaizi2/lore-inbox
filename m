Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTIQUIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbTIQUIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:08:54 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:20890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262635AbTIQUIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:08:53 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <Pine.LNX.4.44.0309162303490.32610-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309162303490.32610-100000@deadlock.et.tudelft.nl>
Message-Id: <1063829278.600.184.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Sep 2003 22:07:58 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Patch: Make iBook1 work again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, the wallstreet doesn't work neither. I get something strange on the
screen. It's somewhat sync'ed but divided in 4 vertical stripes, each one displaying
the left side of the display (+/- offseted), along with some fuzziness (clock wrong).

XFree86 "ati" driver works fine (and manages somewhat to probe the panel type
and clocks properly ...)

It's an LT-G (0x4c47 rev 0x80), 14.31818 XTAL, 230Mhz PLL, 63Mhz MCLK & XCLK
(so far it sounds good), mode properly detected (1024x768-60 from the mac
sense values read in nvram) but the display isn't correct.

I can do register dumps to compare, though I may not have time until next week.

Ben.


