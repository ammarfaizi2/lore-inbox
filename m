Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUARTXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 14:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbUARTXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 14:23:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31758 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263303AbUARTXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 14:23:40 -0500
Date: Sun, 18 Jan 2004 19:23:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] i8042 suspend
Message-ID: <20040118192336.L19593@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401030356.48071.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Sat, Jan 03, 2004 at 03:56:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 03:56:45AM -0500, Dmitry Torokhov wrote:
> ===================================================================
> 
> 
> ChangeSet@1.1571, 2004-01-02 00:22:32-05:00, dtor_core@ameritech.net
>   Input: Add suspend methods to restore original controller state
>          on suspend as some BIOS don't like the state we leave it in.
>          Also synchroniously delete the polling timer on module exit.
> 
> 
>  i8042.c |   76 +++++++++++++++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 54 insertions(+), 22 deletions(-)

Anyone know what the state of this patch is?  I notice that the 2.6-merged
i8042.c still doesn't disable the polling timer on suspend.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
