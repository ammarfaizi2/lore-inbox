Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSFTNJl>; Thu, 20 Jun 2002 09:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSFTNJk>; Thu, 20 Jun 2002 09:09:40 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:26781 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S314381AbSFTNJj>; Thu, 20 Jun 2002 09:09:39 -0400
Date: Thu, 20 Jun 2002 15:10:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6
In-Reply-To: <3D11C8BC.5A14379C@aitel.hist.no>
Message-ID: <Pine.GSO.3.96.1020620144211.18164B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Helge Hafting wrote:

> Yes, the hardware is at fault.  I don't have money for 
> other hardware though, so working around it seems a good idea.  

 What's the problem with using a privately patched kernel then?  I do that
all the time for various stuff.

> We could simplify the IDE driver a lot by dropping support for
> all the broken controllers too. Or tell
> people to not use DMA on them.

 It depends on how intrusive and reliable the workarounds are.  If merely
slowing down or using PIO is sufficient, then they may be OK to include.

> The safe solution is NOAPIC, this fix simply makes it work
> for a longer time using the bad apic.

 Well, consider it *the* workaround, then.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

