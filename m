Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWHQPwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWHQPwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWHQPwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:52:00 -0400
Received: from arrakeen.ouaza.com ([212.85.152.62]:36044 "EHLO
	arrakeen.ouaza.com") by vger.kernel.org with ESMTP id S932367AbWHQPv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:51:59 -0400
Date: Thu, 17 Aug 2006 17:48:42 +0200
From: Raphael Hertzog <hertzog@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Paul Fulghum <paulkf@microgate.com>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060817154842.GB10818@ouaza.com>
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain> <20060816231033.GB12407@flint.arm.linux.org.uk> <1155806446.15195.42.camel@localhost.localdomain> <20060817092811.GA28474@flint.arm.linux.org.uk> <1155815832.15195.80.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155815832.15195.80.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006, Alan Cox wrote:
> > > > is there's something in the system starving interrupt servicing.
> > > > Serial is very sensitive to that, and increases in other system
> > > > latencies tends to have an adverse impact on serial.
> > > 
> > > I see no support for the 16650 specific bits in the driver, so that
> > > alone may be a problem ?
> > 
> > Huh?  16550 not 16650.  Did you miss this?
> 
> Raphael said "I forgot to mention the kind of UART in my mail but it is
> a 16650A"

That's a typo. :-/ 
Two lines further in the same mail there was:

bash-2.05a# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:31 rx:7 RTS|CTS|DTR|DSR
        ^^^^^^

So I meant 16550A. Sorry.

Regards,
-- 
Raphaël Hertzog

Premier livre français sur Debian GNU/Linux :
http://www.ouaza.com/livre/admin-debian/
