Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129750AbRBBS0A>; Fri, 2 Feb 2001 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbRBBSZv>; Fri, 2 Feb 2001 13:25:51 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:6855 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129750AbRBBSZm>; Fri, 2 Feb 2001 13:25:42 -0500
Date: Fri, 2 Feb 2001 19:20:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@redhat.com>
cc: Manfred <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: mpparse.c question
In-Reply-To: <Pine.LNX.4.32.0102021243440.1529-100000@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.3.96.1010202191456.28509R-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Ingo Molnar wrote:

> (hm, dont we have an assert in there to catch ISA IRQs bound to the second
> IO-APIC?) In any case, it would be a very surprising move if anyone added
> a second IO-APIC for the sake of *ISA* devices. This would be truly
> backwards.

 It's just the matter of the order I/O APICs are listed in the MP table. 
I think it's only the limited number of multiple-I/O APIC systems
available so far that prevented from a reverse listing to happen.  Given
recent developments which lead to more such systems (e.g. using the
infamous ServerWorks chipset which embeds two I/O APICs internally), it's
only the matter of time until this happens, I'm afraid. 

 No need to hurry, though -- we might fix the problem once (if) it
appears. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
