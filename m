Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132695AbRAQRx7>; Wed, 17 Jan 2001 12:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132575AbRAQRxt>; Wed, 17 Jan 2001 12:53:49 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:43396 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S132695AbRAQRxf>; Wed, 17 Jan 2001 12:53:35 -0500
Date: Wed, 17 Jan 2001 18:53:12 +0100
From: Petr Matula <pem@informatics.muni.cz>
To: Duncan Laurie <duncan@virtualwire.org>
Cc: linux-kernel@vger.kernel.org, randy.dunlap@intel.com,
        torvalds@transmeta.com, pem@informatics.muni.cz
Subject: Re: int. assignment on SMP + ServerWorks chipset
Message-ID: <20010117185312.B13171968@aisa.fi.muni.cz>
In-Reply-To: <3A64F7E2.30807@virtualwire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A64F7E2.30807@virtualwire.org>; from duncan@virtualwire.org on Tue, Jan 16, 2001 at 06:39:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 06:39:46PM -0700, Duncan Laurie wrote:
> Here's a patch to find & correct this entry on boot.  Its not pretty,
> and should ONLY be used to verify this particular fix--any real solution
> will have to be done in the BIOS.  (there doesn't seem to be an easy way
> to alter specific MP table entries outside of the BIOS, especially if
> they happen to exist in write-protected memory regions...)
I wanted to try your patch, but I got:
patch: **** malformed patch at line 12: if ((m->mpc_irqtype == 0) && ((m->mpc_irqflag & 3) == 3) &&

Which kernel is the patch against?

Petr

---------------------------------------------------------------
 Petr Matula                                    pem@fi.muni.cz
                                    http://www.fi.muni.cz/~pem
---------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
