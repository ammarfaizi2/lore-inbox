Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWHQJAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWHQJAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWHQJAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:00:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5052 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932334AbWHQJAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:00:41 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>, Lee Revell <rlrevell@joe-job.com>,
       Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060816231033.GB12407@flint.arm.linux.org.uk>
References: <20060816104559.GF4325@ouaza.com>
	 <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com>
	 <1155762739.7338.18.camel@mindpipe>
	 <1155767066.2600.19.camel@localhost.localdomain>
	 <20060816231033.GB12407@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 10:20:46 +0100
Message-Id: <1155806446.15195.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 00:10 +0100, ysgrifennodd Russell King:
> MIDI uses its own driver - sound/drivers/serial-u16550.c.  My guess

How peculiar

> is there's something in the system starving interrupt servicing.
> Serial is very sensitive to that, and increases in other system
> latencies tends to have an adverse impact on serial.

I see no support for the 16650 specific bits in the driver, so that
alone may be a problem ?

