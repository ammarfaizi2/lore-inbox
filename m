Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTDNQS1 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTDNQS1 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:18:27 -0400
Received: from palrel11.hp.com ([156.153.255.246]:11724 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263535AbTDNQSY (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:18:24 -0400
Date: Mon, 14 Apr 2003 09:30:13 -0700
To: Russell King <rmk@arm.linux.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew.Morton@digeo.com
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030414163013.GA2402@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk> <20030408174443.GA23935@bougret.hpl.hp.com> <20030413170439.B855@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413170439.B855@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 05:04:39PM +0100, Russell King wrote:
> Jean,
> 
> How about this patch - this also moves the ioctl parsing to the tty
> layer.  I'm intending all drivers should provide tiocmget and tiocmset
> methods if they implement modem control lines, and not parse the
> corresponding ioctl command numbers in their ioctl method.
> 
> Note - this patch has only been compile-tested except for the last file,
> and may apply with an offset(s).  The irtty-sir patch is actually yours;
> I just edited your patch for that file since it was a straight forward
> change.

	Looks good. I'm going to test that and report.
	Thanks a lot !

	Jean
