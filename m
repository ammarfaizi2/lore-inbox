Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTIGTTk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTIGTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 15:19:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:1516 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261350AbTIGTTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 15:19:38 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Schwebel <robert@schwebel.de>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20030907182628.GC482@pengutronix.de>
References: <20030907112813.GQ14436@fs.tum.de>
	 <20030907124251.GC5460@pengutronix.de> <20030907130034.GT14436@fs.tum.de>
	 <1062955895.16972.13.camel@dhcp23.swansea.linux.org.uk>
	 <20030907174834.GA482@pengutronix.de>
	 <1062957851.16964.42.camel@dhcp23.swansea.linux.org.uk>
	 <20030907182628.GC482@pengutronix.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062962239.19073.9.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sun, 07 Sep 2003 20:17:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 19:26, Robert Schwebel wrote:
> my first RTAI tests it surely has several problems which might require
> an #ifdef CONFIG_MGEODE or something similar. As long as this is
> possible everything's ok with me ;)

Lots of the geode hardware is emulated by SMM code, it makes hard real
time on the Geode an 'interesting' world and does limit the latency you
can achieve. Its actually a lot better than say the Dell BIOS battery
SMM seems to be but its not insubstantial at times.

rdtsc before and after an inb/outb is most fascinating 8)


