Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbRENSWl>; Mon, 14 May 2001 14:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262361AbRENSWb>; Mon, 14 May 2001 14:22:31 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:22276 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S262358AbRENSWT>;
	Mon, 14 May 2001 14:22:19 -0400
Date: Mon, 14 May 2001 11:22:16 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        =?iso-8859-1?Q?Mads_Martin_J=F8rgensen?= <mmj@suse.com>,
        Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
Subject: Re: PATCH 2.4.4.ac8: Tulip net driver fixes
Message-ID: <20010514112216.A25436@lucon.org>
In-Reply-To: <3AFD8E2E.302F1AB5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFD8E2E.302F1AB5@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, May 12, 2001 at 03:25:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 03:25:34PM -0400, Jeff Garzik wrote:
> Attached is a patch against 2.4.4-ac8 which includes several fixes to
> the Tulip driver.  This should fix the reported PNIC problems, as well
> as problems with forcing media on MII phys and several other bugs.
> 

Your patch doesn't apply to 2.4.4-ac8 cleanly:

patching file drivers/net/tulip/ChangeLog
Hunk #1 FAILED at 1.
Hunk #2 succeeded at 104 (offset -35 lines).
1 out of 3 hunks FAILED -- saving rejects to file
drivers/net/tulip/ChangeLog.rej
patching file drivers/net/tulip/media.c
Hunk #2 succeeded at 409 (offset -2 lines).
Hunk #3 succeeded at 444 (offset 2 lines).
Hunk #4 succeeded at 455 (offset -2 lines).
patching file drivers/net/tulip/tulip.h
Hunk #1 succeeded at 382 (offset -22 lines).
patching file drivers/net/tulip/tulip_core.c
Hunk #1 FAILED at 24.
Hunk #2 succeeded at 160 (offset -2 lines).
Hunk #4 succeeded at 885 (offset -2 lines).
Hunk #5 FAILED at 1169.
Hunk #6 succeeded at 1432 (offset -82 lines).
Hunk #7 FAILED at 1442.
Hunk #8 succeeded at 1612 (offset -22 lines).
3 out of 8 hunks FAILED -- saving rejects to file
drivers/net/tulip/tulip_core.c.rej

I tried 2.4.4-ac9. It has the same problem. The kernel IP config still
doesn't work. But the user space DHCP works fine.


H.J.


