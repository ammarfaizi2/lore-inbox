Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbTI3FOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 01:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTI3FOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 01:14:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27652 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263105AbTI3FOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 01:14:42 -0400
Date: Mon, 29 Sep 2003 22:09:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030929220916.19c9c90d.davem@redhat.com>
In-Reply-To: <20030928232403.GX15338@fs.tum.de>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003 01:24:03 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> This is broken since it's legal to compile a module much later than the 
> kernel.

Not in this case.

For things inside the kernel, what ipv6 is doing is completely legal.
Changing your config setting in any way in the main kernel tree can
change just about anything else in the kernel, including the layout
of structures.

