Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVDDO3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDDO3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVDDO3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:29:25 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:59328 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261248AbVDDO3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:29:14 -0400
Subject: Re: [RESEND 1] 8250_hp300: unuse register_serial/unregister_serial
From: Kars de Jong <jongk@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050404150617.A12975@flint.arm.linux.org.uk>
References: <20050404094934.A32454@flint.arm.linux.org.uk>
	 <Pine.LNX.4.62.0504041051390.14107@numbat.sonytel.be>
	 <1112622212.5662.7.camel@kars.perseus.home>
	 <20050404150617.A12975@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:29:10 +0200
Message-Id: <1112624950.5662.11.camel@kars.perseus.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 15:06 +0100, Russell King wrote:

> Thanks for testing.  I've incorporated your changes.  One question - do
> you need linux/serial.h included in there?

Yes, because it contains the prototype for early_serial_setup().

It might be a good idea to use the early_serial_console_init() instead
though.


Kind regards,

Kars.


