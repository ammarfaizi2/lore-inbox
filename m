Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVIIQd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVIIQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVIIQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:33:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29965 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751429AbVIIQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:33:57 -0400
Date: Fri, 9 Sep 2005 17:33:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       paulkf@microgate.com
Subject: Re: [PATCH] gratitious includes of asm/serial.h
Message-ID: <20050909173324.B2464@flint.arm.linux.org.uk>
Mail-Followup-To: viro@ZenIV.linux.org.uk,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	paulkf@microgate.com
References: <20050909160251.GH9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050909160251.GH9623@ZenIV.linux.org.uk>; from viro@ZenIV.linux.org.uk on Fri, Sep 09, 2005 at 05:02:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 05:02:51PM +0100, viro@ZenIV.linux.org.uk wrote:
> Removed gratitious includes of asm/serial.h in synklinkmp and ip2main.
> Allows to remove the rest of "broken on sparc32" in drivers/char - this
> stuff doesn't break the build anymore.  Since it got zero testing, it almost
> certainly won't work there, though...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

This stuff does need fixing.  One day, I hope to completely remove the
asm-*/serial.h includes from the kernel.

Thanks Al.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
