Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUFEWSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUFEWSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFEWSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:18:16 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:26808 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262106AbUFEWSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:18:15 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jgarzik@pobox.com, dctucker@hotmail.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: PROBLEM: network driver causes kernel panic
References: <200406051215.i55CF4hH004189@harpo.it.uu.se>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 05 Jun 2004 22:43:32 +0200
In-Reply-To: <200406051215.i55CF4hH004189@harpo.it.uu.se> (Mikael
 Pettersson's message of "Sat, 5 Jun 2004 14:15:04 +0200 (MEST)")
Message-ID: <m38yf1viq3.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Booting 2.6.7-rc1 with the de2104x driver built-in and eth0
> disconnected from the LAN leads to the following oops about
> a second after INIT tried to ifup eth0:
>
> eth0: timeout expired stopping DMA
> kernel BUG in de_set_media at drivers/net/tulip/de2104x.c:919!

Same here, i386, SMC EtherPower^2 (dual 21040 + 21050 PCI bridge).
-- 
Krzysztof Halasa, B*FH
