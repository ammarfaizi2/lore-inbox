Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVDDRFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVDDRFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVDDRFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:05:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261246AbVDDRFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:05:38 -0400
Date: Mon, 4 Apr 2005 18:05:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix u32 vs. pm_message_t in arm
Message-ID: <20050404180520.C12975@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050329191543.GA8309@elf.ucw.cz> <20050403113804.A921@flint.arm.linux.org.uk> <20050403104414.GE1357@elf.ucw.cz> <20050404174923.B12975@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504041002080.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504041002080.2215@ppc970.osdl.org>; from torvalds@osdl.org on Mon, Apr 04, 2005 at 10:02:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:02:35AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 4 Apr 2005, Russell King wrote:
> > 
> > Linus - is the pm.h included in sysdev.h in -rc2?
> 
> Nope. Just includes kobject.h

Oh dear - in that case, most of ARM will be broken in -rc2. ;(

	http://armlinux.simtec.co.uk/kautobuild/2.6.12-rc1-bk6/index.html

contains the bad news for -rc1-bk6, and -rc2 will be the same story.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
