Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSGBXXH>; Tue, 2 Jul 2002 19:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSGBXXH>; Tue, 2 Jul 2002 19:23:07 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6675 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314096AbSGBXXG>; Tue, 2 Jul 2002 19:23:06 -0400
Date: Wed, 3 Jul 2002 01:25:31 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-ID: <20020702232530.GC2014@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1020702120824.28259A-100000@gatekeeper.tmr.com> <3D21DD2A.2010801@PolesApart.wox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D21DD2A.2010801@PolesApart.wox.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2002, Alexandre P. Nunes wrote:

> How this taint stuff works, actually ? It's just a marker or it impose 
> any restrictions?
> 
> While I made all efforts to send nvidia all information pertinent to the 
> reported bug, I also found that the source to o/s dependent parts are in 
> fact (at least partially) available, with an absurdly restrictive 
> license, though. If someone else is interested in looking at, one of the 
> files in the distribution contains the mm code and all general 
> interfacing to the kernel.
> 
> I agree it's nvidia responsability for checking its own source, but help 
> is always welcome when it's true help after all.
> 
> In last weekend I patched 2.4.19-pre10-ac2 with the last preempt-kernel 
> patch, and since I was unable to reproduce the crash, though I didn't 
> stress the machine enough by lack of time, so it's just informative 
> report in case someone want to try.

I didn't get the start of this thread, but I have seen bugs at
page_alloc.c:131 and :117 with a "stock" 2.4.19-pre10-ac2. It not really
Alan's version because I have Chris Mason's reiserfs logging patches, a
BSD super.c fix and the bridge-netfilter patch.

The bug usually strikes at shutdown of the X server, and I have yet to
see this with the opensource nv X11 driver.

Is providing Nvidia with information do any good? Do they respond to bug
reports and actually fix bugs? It might be that they just need to track
new VM behaviour, but I can save the time of writing a bug report if
it's either no good or if someone already did.

-- 
Matthias Andree
