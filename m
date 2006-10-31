Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423856AbWJaXiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423856AbWJaXiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423861AbWJaXiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:38:17 -0500
Received: from mail.gmx.de ([213.165.64.20]:46288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423856AbWJaXiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:38:16 -0500
X-Authenticated: #20450766
Date: Wed, 1 Nov 2006 00:37:56 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at,
       Darren Salt <linux@youmustbejoking.demon.co.uk>,
       Syed Azam <syed.azam@hp.com>,
       Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known
 regressions)
In-Reply-To: <20061031230538.GA4329@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.60.0611010028360.3884@poirot.grange>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
 <20061030120158.GA28123@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange>
 <20061030234425.GB6038@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610312000160.5223@poirot.grange> <20061031230538.GA4329@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Francois Romieu wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
> 
> > in to see if it ever fails. So, what does it tell us about the 
> > set_mac_address thing?
> 
> It tells nothing more about the set_mac_address thing. If people need 
> MAC address change support, I can surely hack something and keep a
> patch for future reference. Imho it is anything but 2.6.19 material
> though.

Aha, ok, thanks. Just noticed that the set_mac_address has been reverted 
in -rc4, so, that's resolved. Good.

> Your computer was good at spotting issues with the MAC address stuff,
> so it was the perfect candidate to test pending fixes for different
> problems. As you noticed, it was not exactly safe to feed the MII
> control register with some potentially uninitialized stuff, whence
> the patch from yesterday.

Glad it was useful. I have to warn you though, that that "computer" is not 
very actively used ATM and doesn't stay on for too long. However, if you 
can suggest a way to stress test that phy reset thingie, I could run some 
overnight test.

Thanks
Guennadi
---
Guennadi Liakhovetski
