Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423559AbWJaTCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423559AbWJaTCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423795AbWJaTCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:02:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:53678 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423559AbWJaTCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:02:45 -0500
X-Authenticated: #20450766
Date: Tue, 31 Oct 2006 20:02:39 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known
 regressions)
In-Reply-To: <20061030234425.GB6038@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.60.0610312000160.5223@poirot.grange>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
 <20061030120158.GA28123@electric-eye.fr.zoreil.com>
 <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange>
 <20061030234425.GB6038@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, Francois Romieu wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
> [...]
> > The "seems" above was the key word. Once again I had a case, when after 
> > re-compiling the kernel again with the disabled call to 
> > __rtl8169_set_mac_addr only ping worked. And a power-off was required to 
> > recover. So, that phy_reset doesn't seem to be very safe either.
> 
> Can you replace phy_reset by the patch below and try it twice ?
> 
> It's interesting to know if it does not always behave the same.

Well, with that one I booted 3 times, all 3 times it worked. I'll leave it 
in to see if it ever fails. So, what does it tell us about the 
set_mac_address thing?

Thanks
Guennadi
---
Guennadi Liakhovetski
