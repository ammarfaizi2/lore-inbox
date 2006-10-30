Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWJ3WIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWJ3WIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422680AbWJ3WIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:08:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:2736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422679AbWJ3WIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:08:43 -0500
X-Authenticated: #20450766
Date: Mon, 30 Oct 2006 22:17:19 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known
 regressions)
In-Reply-To: <Pine.LNX.4.60.0610302148560.9723@poirot.grange>
Message-ID: <Pine.LNX.4.60.0610302214350.9723@poirot.grange>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
 <20061030120158.GA28123@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610302148560.9723@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Guennadi Liakhovetski wrote:

> Ok, with just __rtl8169_set_mac_addr disabled it works. With netconsole 
> disabled, and your phy_reset patch applied it seems to still work. The 

The "seems" above was the key word. Once again I had a case, when after 
re-compiling the kernel again with the disabled call to 
__rtl8169_set_mac_addr only ping worked. And a power-off was required to 
recover. So, that phy_reset doesn't seem to be very safe either.

Thanks
Guennadi
---
Guennadi Liakhovetski
