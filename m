Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLGWJS>; Thu, 7 Dec 2000 17:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbQLGWJI>; Thu, 7 Dec 2000 17:09:08 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:22510
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129406AbQLGWIy>; Thu, 7 Dec 2000 17:08:54 -0500
Date: Thu, 7 Dec 2000 14:37:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12-pre7
Message-ID: <20001207143713.L28563@opus.bloom.county>
In-Reply-To: <200012071411.eB7EB4Y11843@flint.arm.linux.org.uk> <Pine.LNX.4.10.10012071957480.13783-100000@chaos.thphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012071957480.13783-100000@chaos.thphy.uni-duesseldorf.de>; from kai@thphy.uni-duesseldorf.de on Thu, Dec 07, 2000 at 08:01:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 08:01:13PM +0100, Kai Germaschewski wrote:

> Maybe I'm stating something which is obvious to everybody, but note
> that pci_assign_unassigned_resources is only called from

Possibly, but I don't know either. :)

> ./arch/alpha/kernel/pci.c:  pci_assign_unassigned_resources();
> ./arch/mips/ddb5074/pci.c:  pci_assign_unassigned_resources();
> ./arch/arm/kernel/bios32.c:     pci_assign_unassigned_resources();
> 
> so it looks like most archs don't use it anyway. (And that's supposedly
> why pci_set_master helped people on x86)

You're assuming all arches are up to date.  Silly you. :)  I know there's a
patch to use this for some PReP (PPC) machines.  It's quite possible other
arches might be using this but aren't synced up to Linus.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
