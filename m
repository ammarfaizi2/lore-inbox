Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTDJCST (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 22:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTDJCST (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 22:18:19 -0400
Received: from palrel10.hp.com ([156.153.255.245]:41453 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261695AbTDJCST (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 22:18:19 -0400
Date: Wed, 9 Apr 2003 19:29:58 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030410022958.GB2270@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404102535.A29313@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 10:25:35AM +0100, Russell King wrote:
> On Thu, Apr 03, 2003 at 05:34:05PM -0800, Jean Tourrilhes wrote:
> > 	Unfortunately, the irtty-sir driver, which is a TTY line
> > discipline and a network driver, need to be able to change the RTS and
> > DTR line from a kernel thread.
> 
> I'd prefer if we added an tty API to allow line disciplines to read/set
> the modem control lines to the tty later, rather than having line
> disciplines play games with IOCTLs.

	Hi,

	Who is responsible to managing the TTY API ? If I want to add
a call to it, who am I supposed to send the patch to ?
	Thanks in advance...

	Jean
