Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTJJQHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTJJQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:04:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58641 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262948AbTJJQEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:04:21 -0400
Date: Fri, 10 Oct 2003 17:04:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thom Borton <borton@phys.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA CD-ROM does not work
Message-ID: <20031010170402.E4702@flint.arm.linux.org.uk>
Mail-Followup-To: Thom Borton <borton@phys.ethz.ch>,
	linux-kernel@vger.kernel.org
References: <200310101652.53796.borton@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200310101652.53796.borton@phys.ethz.ch>; from borton@phys.ethz.ch on Fri, Oct 10, 2003 at 04:52:50PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 04:52:50PM +0200, Thom Borton wrote:
> Oct 10 09:38:57 grisu kernel: Yenta: CardBus bridge found at 0000:00:0c.0 [104d:8082]
> Oct 10 09:38:57 grisu kernel: Yenta: ISA IRQ list 00b8, PCI irq9
> Oct 10 09:38:57 grisu kernel: Socket status: 30000086
> Oct 10 09:38:58 grisu cardmgr[411]: watching 1 socket
> Oct 10 09:38:58 grisu cardmgr[412]: starting, version is 3.2.5
> Oct 10 09:39:15 grisu cardmgr[412]: socket 0: Ninja ATA
> Oct 10 09:39:15 grisu kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xdc000-0xdffff 0xe8000-0xfffff
> Oct 10 09:39:15 grisu cardmgr[412]: executing: 'modprobe ide-cs'
> Oct 10 09:39:15 grisu kernel: ide-cs: RequestIRQ: Unsupported mode
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You turned off CONFIG_ISA.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
