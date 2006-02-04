Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945989AbWBDQSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWBDQSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945995AbWBDQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:18:08 -0500
Received: from khc.piap.pl ([195.187.100.11]:38663 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1945989AbWBDQSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:18:07 -0500
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
	<1138844838.5557.17.camel@localhost.localdomain>
	<43E2B8D6.1070707@aarnet.edu.au>
	<20060203094042.GB30738@flint.arm.linux.org.uk>
	<43E36850.5030900@aarnet.edu.au>
	<20060203160218.GA27452@flint.arm.linux.org.uk>
	<43E38E00.301@aarnet.edu.au>
	<20060203222340.GB10700@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 04 Feb 2006 17:18:05 +0100
In-Reply-To: <20060203222340.GB10700@flint.arm.linux.org.uk> (Russell King's message of "Fri, 3 Feb 2006 22:23:40 +0000")
Message-ID: <m3irrvdrnm.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> What about those who have incomplete null modem cables which might
> not connect DCD or DSR, but who want to use hardware flow control?

BTW: Obviously CRTSCTS is a different thing than a modem with
hardware handshaking. Basically CRTSCTS is a fixed, transparent
line. So if we do Hayes modem console, it would better be another
option.
-- 
Krzysztof Halasa
