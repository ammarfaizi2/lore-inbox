Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTDNQTb (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTDNQTb (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:19:31 -0400
Received: from palrel10.hp.com ([156.153.255.245]:28315 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263539AbTDNQT3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:19:29 -0400
Date: Mon, 14 Apr 2003 09:31:18 -0700
To: Russell King <rmk@arm.linux.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030414163118.GB2402@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk> <20030408174443.GA23935@bougret.hpl.hp.com> <20030413175104.A15846@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413175104.A15846@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 05:51:04PM +0100, Russell King wrote:
> On Tue, Apr 08, 2003 at 10:44:43AM -0700, Jean Tourrilhes wrote:
> > 	I was tempted to create the same API for setting the speed
> > (baud rate), but that may need to wait for another time.
> 
> I'm not intending changing the settermios API - it would be rather
> inefficient to have a set of "set baud rate", "set stop bits",
> "set bits per character", "set parity error response" etc calls,
> especially when many of these involve writing the same set of
> registers in the UART.

	Don't worry, the current situation is workable.

	Jean
