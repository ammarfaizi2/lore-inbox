Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVGNI0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVGNI0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 04:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVGNI0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 04:26:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14355 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262964AbVGNI0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 04:26:53 -0400
Date: Thu, 14 Jul 2005 09:26:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9: serial_core: uart_open
Message-ID: <20050714092648.C26322@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0507130850110.18969@chaos.analogic.com> <NDBBKFNEMLJBNHKPPFILAEAICEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILAEAICEAA.karl@petzent.com>; from karl@petzent.com on Wed, Jul 13, 2005 at 10:53:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 10:53:19AM -0700, karl malbrain wrote:
> I've also noticed that the boot sequence probes for modems on the serial
> ports.  Is it possible that 8250.c is having a problem servicing an
> interrupt from a character/state-change left over from this initialization?

I did ask for a process listing a while back.  I don't want to
speculate on possible causes until we have some real information
from the system as to what's going on.

Please run up your test program and get the machine into the
problematic state.  Let it remain like that for about 2 minutes,
and then run via a telnet session or other window:

ps aux > /tmp/ps-forrmk.txt

and send me that file.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
