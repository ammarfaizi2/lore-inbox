Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbTIGSGV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTIGSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:06:21 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48875 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263417AbTIGSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:06:20 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Schwebel <robert@schwebel.de>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20030907174834.GA482@pengutronix.de>
References: <20030907112813.GQ14436@fs.tum.de>
	 <20030907124251.GC5460@pengutronix.de> <20030907130034.GT14436@fs.tum.de>
	 <1062955895.16972.13.camel@dhcp23.swansea.linux.org.uk>
	 <20030907174834.GA482@pengutronix.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062957851.16964.42.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 07 Sep 2003 19:04:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-07 at 18:48, Robert Schwebel wrote:
> It seems to be similar to the Elan: the core is "just another PC", but
> in several places you need to know that you have a Geode so that you can
> provide the right tweaks and fixes. 

ELAN is "like a PC", Geode is a PC, to software. You can run a generic
386/486/586/586+MMX kernel on a Geode CPU. The Geode support just picks
the right compile options and our setup code turns on some handy CPU
features we can use

