Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTI3GgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTI3GdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:33:17 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:10427 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263174AbTI3Gcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:32:54 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030929220916.19c9c90d.davem@redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
Message-Id: <1064903562.6154.160.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 07:32:42 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 22:09 -0700, David S. Miller wrote:
> For things inside the kernel, what ipv6 is doing is completely legal.
> Changing your config setting in any way in the main kernel tree can
> change just about anything else in the kernel, including the layout
> of structures.

With boolean options that's fair enough. But changing any config option
from 'n' to 'm' should not change anything in the main kernel. To do so
is confusing and should be considered broken, as Adrian says.

-- 
dwmw2


