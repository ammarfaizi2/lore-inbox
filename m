Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSFUNCu>; Fri, 21 Jun 2002 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSFUNCt>; Fri, 21 Jun 2002 09:02:49 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:22791 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316588AbSFUNCt>; Fri, 21 Jun 2002 09:02:49 -0400
Message-ID: <3D1323EB.11BF8DB2@aitel.hist.no>
Date: Fri, 21 Jun 2002 15:02:35 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6
References: <Pine.GSO.3.96.1020620144211.18164B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Thu, 20 Jun 2002, Helge Hafting wrote:
> 
> > Yes, the hardware is at fault.  I don't have money for
> > other hardware though, so working around it seems a good idea.
> 
>  What's the problem with using a privately patched kernel then?  I do that
> all the time for various stuff.
Nothing wrong with that.  I may be wrong, but I have the impression
that the bp6 was quite popular for a while.  It was the only
cheap smp board for a while (excluding those who re-soldered
their cpu's to enable SMP in other boards) 
and it took some time before people realized that a good
PSU and extra cooling wasn't enough.
> 
> > We could simplify the IDE driver a lot by dropping support for
> > all the broken controllers too. Or tell
> > people to not use DMA on them.
> 
>  It depends on how intrusive and reliable the workarounds are.  If merely
> slowing down or using PIO is sufficient, then they may be OK to include.
> 
My impression is that the IDE driver contains workarounds for many
broken chipsets.  Using DMA is usually
default off but can be turned on for those that know it
won't hurt in their case.

I think a similiar approach is ok with the BP6 fix - put it in
because there are a bunch of these boards, default it OFF because
many more don't need it.

Helge Hafting
