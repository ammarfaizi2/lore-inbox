Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbUKPTkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUKPTkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKPTjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:39:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30472 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262116AbUKPTgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:36:12 -0500
Date: Tue, 16 Nov 2004 19:36:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq and 8250 serial console 2.6.10-rc1-mm3
Message-ID: <20041116193607.G22425@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
References: <1100632653.14403.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1100632653.14403.2.camel@localhost.localdomain>; from rostedt@goodmis.org on Tue, Nov 16, 2004 at 02:17:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 02:17:33PM -0500, Steven Rostedt wrote:
> I don't know if anyone else caught this, but the sysrq doesn't work with
> the serial console for 8250.  This is a simple patch, the serial_8250.h
> also calls serial_core.h before SUPPORT_SYSRQ is defined. And thus the
> inlines in serial core do not support sysrq.

Already fixed in 2.6.10-rc2.

Thanks anyway.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
