Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288212AbSAHR7M>; Tue, 8 Jan 2002 12:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288206AbSAHR7D>; Tue, 8 Jan 2002 12:59:03 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:7307
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288020AbSAHR6m>; Tue, 8 Jan 2002 12:58:42 -0500
Date: Tue, 8 Jan 2002 12:43:34 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Missing entries in Configuure.help)
Message-ID: <20020108124334.A24742@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <20020106210233.A30319@thyrsus.com> <20020107085307.A17914@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107085307.A17914@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Jan 07, 2002 at 08:53:07AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>:
> On Sun, Jan 06, 2002 at 09:02:33PM -0500, Eric S. Raymond wrote:
> > 6xx_GENERIC
> 
> What's this?  Where is it?

Private symbol.  My error; it doesn't need help.
 
> > ARCH_CO285
> > ARCH_FOOTBRIDGE
> > ARCH_SA1100
> > ARCH_SHARK
> > CPU_ARM922_CPU_IDLE
> > CPU_ARM922_D_CACHE_ON
> > CPU_ARM922_I_CACHE_ON
> > CPU_ARM922_WRITETHROUGH
> 
> Erm, I don't believe these have been added since you last complained.
> I don't see how they became a non-issue and are now a problem.  Please
> double-check them.

I know that the ARM 922 symbols came in during the last update; I remember 
having to add them to the rulebase.  I think ARCH_SHARK didn't show up before
this because I had it marked as dead (it got revived recently and I didn't
catch that for a while.

Here is the revised list:

ARM:

ARCH_ADIFCC
ARCH_CAMELOT
ARCH_CLPS7500
ARCH_CO285
ARCH_FOOTBRIDGE
ARCH_IOP310
ARCH_SA1100
ARCH_SHARK
CPU_ARM922_CPU_IDLE
CPU_ARM922_D_CACHE_ON
CPU_ARM922_I_CACHE_ON
CPU_ARM922_WRITETHROUGH
DEBUG_LL_SER3
DEBUG_WAITQ
H3600_SLEEVE
IOP310_AAU
IOP310_DMA
IOP310_MU
IOP310_PMON
SA1100_H3100
SA1100_H3800
SA1100_PT_SYSTEM3
SA1100_SHANNON
SA1100_USB
SA1100_USB_CHAR
SA1100_USB_NETLINK

Non-ARM:

USB_EHCI_HCD
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

What, then is law [government]? It is the collective organization of
the individual right to lawful defense."
	-- Frederic Bastiat, "The Law"
