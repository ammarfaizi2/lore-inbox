Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTJTLGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbTJTLGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:06:13 -0400
Received: from coffee.creativecontingencies.com ([210.8.121.66]:41658 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S262531AbTJTLGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:06:12 -0400
Date: Mon, 20 Oct 2003 21:05:39 +1000
From: Peter Lieverdink <cafuego@coffee.cc.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Message-ID: <20031020110539.GA14214@coffee.cc.com.au>
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201340.48681.dev@sw.ru> <20031020024942.01094ff0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020024942.01094ff0.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re the new framebuffer code, it appears to not work on matroxfb.
On bootup the console gets as far as:

...
found SMP MP-table at 000f4db0
hm, page 000f4000 reserved twice.

And then it stops, whereas normally the framebuffer would kick in with a pengiun and continue booting.
I boot the kernel with "video=matroxfb:vesa:0x192". When I disable it with "video=matroxfb:off" the system
boots fine.

- Peter.
-- 
System/Network Administrator Creative Contingencies P/L
http://www.cafuego.net/pgp-key.php for pgp key
Registered Linux user #108200   http://counter.li.org
