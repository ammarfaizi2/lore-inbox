Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVGPIo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGPIo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVGPIo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:44:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60178 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261240AbVGPIoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:44:13 -0400
Date: Sat, 16 Jul 2005 09:43:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Song <samlinuxkernel@yahoo.com>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050716094359.B19067@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Song <samlinuxkernel@yahoo.com>, mgreer@mvista.com,
	david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <20050714114220.C31383@flint.arm.linux.org.uk> <20050715051136.25530.qmail@web32013.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050715051136.25530.qmail@web32013.mail.mud.yahoo.com>; from samlinuxkernel@yahoo.com on Thu, Jul 14, 2005 at 10:11:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:11:36PM -0700, Sam Song wrote:
> Well, I use a sandpoint-based board. Not the same as
> the reference one. There are two serial ports on the
> board and I enabled them both with IRQ9/10. 
> In addition, No 8259 on this board.
> 
> Pls don't apply this patch:-)

Indeed I won't.  I was hoping that it was going to be something simple,
but it's not.  We need PPC folk to fix their SERIAL_PORT_DFNS and
remove obsolete stuff like RS_TABLE_SIZE.

Ideally, SERIAL_PORT_DFNS should end up being completely empty.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
