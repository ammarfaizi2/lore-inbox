Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbRAJDxi>; Tue, 9 Jan 2001 22:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132208AbRAJDx2>; Tue, 9 Jan 2001 22:53:28 -0500
Received: from smtp.mountain.net ([198.77.1.35]:45830 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131861AbRAJDxM>;
	Tue, 9 Jan 2001 22:53:12 -0500
Message-ID: <3A5BDC9C.B2A05BC5@mountain.net>
Date: Tue, 09 Jan 2001 22:53:00 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: rob@sysgo.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01010922090000.02630@rob>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kaiser wrote:
> 
> Hi list,
> 
> I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
> The kernel was built for a 386 Processor, Math emulation has been enabled.
> I tried three different 386 boards. Execution seems to get as far as
> pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
> if someone had pressed the reset button. The same kernel boots fine on
> 486 and Pentium Systems.
  ^^^
> 
> Any ideas/suggestions ?
> 
> Rob
> 

This may be off the wall, but since the 386 is diskless the kernel was
obviously built elsewhere. Had that tree previously been used for a 486
build? You might decompile vmlinux and look for non-386 instructions at or
prior to the crash point.

It might be faster to recompile from 'make mrproper' and see if it works
then.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
