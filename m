Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBLM04>; Mon, 12 Feb 2001 07:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129920AbRBLM0q>; Mon, 12 Feb 2001 07:26:46 -0500
Received: from lindy.SoftHome.net ([204.144.232.9]:1038 "HELO
	lindy.softhome.net") by vger.kernel.org with SMTP
	id <S131126AbRBLM0d>; Mon, 12 Feb 2001 07:26:33 -0500
Message-ID: <20010212125314.16109.qmail@lindy.softhome.net>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysinfo.sharedram not accounted for on i386 ? 
Organization: SoftHome
X-URL: http://www.SoftHome.net/
In-Reply-To: Your message of "Mon, 12 Feb 2001 11:58:35 +0100."
             <20010212115835.C1691@arthur.ubicom.tudelft.nl> 
Date: Mon, 12 Feb 2001 05:53:14 -0700
From: Brian Grossman <brian@SoftHome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Feb 12, 2001 at 12:05:03AM -0700, Brian Grossman wrote:
> > On i386, sysinfo.sharedram is not accounted for, leading /proc/meminfo to
> > always report MemShared as 0.  Is this the intended behavior?
> 
> Yes.

Thanks.  Is there a preferred way of getting the equivalent info
as free(1) did under 2.2?

I've written a script to derive it from /proc/[0-9]*/statm, but that seems
like an awkward approach.  A related question: is the page size stored in
/proc somewhere?

Is there a discussion of this somewhere?  I couldn't find one when I
searched the linux-kernel archives.

Brian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
