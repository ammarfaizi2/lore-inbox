Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272548AbTHNQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272560AbTHNQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:47:29 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:5251 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272548AbTHNQr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:47:27 -0400
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
References: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 17:47:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 17:19, Linus Torvalds wrote:
> Does anybody actually _use_ /proc/kcore? It was one of those "cool 
> feature" things, but I certainly haven't ever used it myself except for 
> testing, and it's historically often been broken after various kernel 
> infrastructure updates, and people haven't complained..
> 
> Comments?

Now if you'd agree to merge the kgdb stubs to replace it.... ;)

I see no problem with it either going or becoming an arch specific
module someone can go write if they care about it and insmod if they
actually use.


