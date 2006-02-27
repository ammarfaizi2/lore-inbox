Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWB0BSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWB0BSt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWB0BSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:18:49 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:42381 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751445AbWB0BSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:18:49 -0500
Date: Mon, 27 Feb 2006 02:18:44 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-ID: <20060227011844.GA7218@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org> <20060225215850.GD15276@flint.arm.linux.org.uk> <20060225223737.GO13116@waste.org> <20060225225748.GF15276@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225225748.GF15276@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.241.246
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 10:57:49PM +0000, Russell King wrote:
> On Sat, Feb 25, 2006 at 04:37:37PM -0600, Matt Mackall wrote:
> > On Sat, Feb 25, 2006 at 09:58:50PM +0000, Russell King wrote:
> > > I'm sorry, I just do not see why you're being soo bloody difficult
> > > over this.
> > 
> > Because it's taken this long to get close to an explanation of what
> > the problem is.
> 
> $#%@%#$%#@!!!  I really think you're intentionally trying to wind me up
> through this whole thread.
> 
> The email:
> 
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html
> 
> contains a full and clear explaination of the situation.  The second
> paragraph of that email is key to understanding the problem and makes
> it absolutely clear what is trying to be decompressed as the initrd
> (the corrupted compressed piggy).

FWIW, I didn't it either. "Work around broken boot firmware which passes
invalid initrd to kernel" would have been a simpler description.

I agree that it would be nice if inflate.c would fail gracefully
instead of halting, but why can't you just use CONFIG_BLK_DEV_INITRD=n?


Johannes
