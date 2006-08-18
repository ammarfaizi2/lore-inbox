Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWHRSw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHRSw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWHRSw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:52:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63158 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932385AbWHRSwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:52:55 -0400
Subject: Re: R: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <20060818183430.GD21101@flint.arm.linux.org.uk>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it>
	 <1155920400.24907.63.camel@mindpipe>
	 <20060818170450.GC21101@flint.arm.linux.org.uk>
	 <1155922240.2924.5.camel@mindpipe>
	 <20060818183430.GD21101@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:52:53 -0400
Message-Id: <1155927174.2924.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 19:34 +0100, Russell King wrote:
> That "0000:00:0b.0" looks like a PCI device ID.  If it were a fourport
> board, it would be "serial8250.3" according to the current enumeration
> in linux/serial_8250.h.
> 
> Also, another give away is that IRQ185 is being setup as a PCI interrupt
> immediately prior to the devices being registered.
> 
> And I doubt that an ISA board (which is what fourport is) would ever get
> such a high IRQ number.
> 

So you're saying that the standard 8250 driver is being used?

This is the board they are using:

http://www.moschip.com/html/MCS9845.html

Lee

