Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131121AbRAaH7f>; Wed, 31 Jan 2001 02:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbRAaH7Z>; Wed, 31 Jan 2001 02:59:25 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:28684 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S131121AbRAaH7P>;
	Wed, 31 Jan 2001 02:59:15 -0500
Date: Wed, 31 Jan 2001 08:59:05 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL and 3c59x (3c905c-tx)
In-Reply-To: <Pine.LNX.4.30.0101310812030.13346-100000@svea.tellus>
Message-ID: <Pine.LNX.4.30.0101310853590.13346-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Tobias Ringstrom wrote:
> Would it be enough to port the acpi_wake function to 2.4?  If so, I can do
> that myself.  In fact, I think I'll try that right away.  Who needs
> breakfast anyway? :-)

Ok, I tried it, and it works.  I can now start my computer using WOL
packets after an "init 0" in Linux.

I do not how it behaves in a suspend/wake-up situation, though.  Let me
know when you have a patch for 2.4, and I'll try it.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
