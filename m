Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUAaRXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAaRXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 12:23:25 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:40064 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264954AbUAaRXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 12:23:24 -0500
Date: Sat, 31 Jan 2004 17:32:14 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401311732.i0VHWEbw000681@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <401ACB54.1060304@techsource.com>
References: <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
 <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com>
 <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com>
 <401A33CA.4050104@aitel.hist.no>
 <401A8E0E.6090004@techsource.com>
 <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
 <401A9716.3040607@techsource.com>
 <20040130210915.GA4147@hh.idb.hist.no>
 <401ACB54.1060304@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Timothy Miller <miller@techsource.com>:
> Alright then, how about this:  Assuming opencores has a PCI interface 
> and a DDR memory controller, I could write a CRT controller.  We can put 
> that into an FPGA and see what happens.

Well, there is a PCI to wishbone bridge:

http://www.opencores.org/projects/pci/

and a DDR memory controller:

http://www.opencores.org/projects/ddr_sdr/

but do we really need DDR RAM?  For the small amount of RAM on the
card, (8 or 16 MB at the most), surely the cost of standard static ram
ICs wouldn't be too off-putting, and it would presumably simplify the
design slightly.

(It's you that's got to build it, though, so it's your call :-) ).

John.
