Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSKVPzr>; Fri, 22 Nov 2002 10:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKVPzr>; Fri, 22 Nov 2002 10:55:47 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:27879 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S264976AbSKVPzq>; Fri, 22 Nov 2002 10:55:46 -0500
Date: Fri, 22 Nov 2002 09:02:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] Add back in <asm/system.h> and <linux/linkage.h> to <linux/interrupt.h>
Message-ID: <20021122160254.GQ779@opus.bloom.county>
References: <20021122152132.GP779@opus.bloom.county> <20021122155552.B2290@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021122155552.B2290@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 03:55:52PM +0000, Russell King wrote:
> On Fri, Nov 22, 2002 at 08:21:32AM -0700, Tom Rini wrote:
> > The following trivial patch adds back <asm/system.h> and
> > <linux/kernel.h> to <linux/interrupt.h>.  Without it,
> > <linux/interrupt.h> is relying on <asm/system.h> to be implicitly
> > included for smb_mb to be defined, and <linux/linkage.h> to be implicitly
> > included for asmlinkage/FASTCALL/etc.
> > 
> > Apparently RMK sent a similar patch, which did not add in
> 
> This bit is a myth.

Well I blame Pete then. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
