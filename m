Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSKVPsr>; Fri, 22 Nov 2002 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSKVPsr>; Fri, 22 Nov 2002 10:48:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50440 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264975AbSKVPsq>; Fri, 22 Nov 2002 10:48:46 -0500
Date: Fri, 22 Nov 2002 15:55:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] Add back in <asm/system.h> and <linux/linkage.h> to <linux/interrupt.h>
Message-ID: <20021122155552.B2290@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021122152132.GP779@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021122152132.GP779@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Nov 22, 2002 at 08:21:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 08:21:32AM -0700, Tom Rini wrote:
> The following trivial patch adds back <asm/system.h> and
> <linux/kernel.h> to <linux/interrupt.h>.  Without it,
> <linux/interrupt.h> is relying on <asm/system.h> to be implicitly
> included for smb_mb to be defined, and <linux/linkage.h> to be implicitly
> included for asmlinkage/FASTCALL/etc.
> 
> Apparently RMK sent a similar patch, which did not add in

This bit is a myth.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

