Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317410AbSGDNd0>; Thu, 4 Jul 2002 09:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317413AbSGDNdZ>; Thu, 4 Jul 2002 09:33:25 -0400
Received: from ns.suse.de ([213.95.15.193]:27920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317410AbSGDNdX>;
	Thu, 4 Jul 2002 09:33:23 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Kernel release management
References: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com.suse.lists.linux.kernel> <200207030718.g637I0L145202@pimout2-int.prodigy.net.suse.lists.linux.kernel> <20020704131654.B11601@flint.arm.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Jul 2002 15:35:55 +0200
In-Reply-To: Russell King's message of "4 Jul 2002 14:23:19 +0200"
Message-ID: <p73it3vwr7o.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:


> If stuff in 2.5 wasn't soo broken (looking at IDE here) then more people
> would be using it, and less people would be wanting the 2.5 features back
> ported to 2.4.  IMHO, at the moment 2.5 has a major problem.  It is not
> getting the testing it deserves because things like IDE and such like
> aren't reasonably stable enough.

I have to second RMK's complaint. Testing 2.5 (in this case with x86-64)
is a major problem unless you're lucky enough to find a SCSI adapter 
and a SCSI disk. IDE just deadlocks and hangs too often. This prevents
testing everything else and stops development in 2.5 for many things.
I don't think the 2.5 release cycle can afford to lose the testers who
only have IDE machines.

-Andi
