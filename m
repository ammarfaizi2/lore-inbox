Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUA3RVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUA3RVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:21:01 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:36743 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262827AbUA3RU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:20:59 -0500
Date: Fri, 30 Jan 2004 18:20:57 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Timothy Miller <miller@techsource.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, John Bradford <john@grabjohn.com>,
       chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
In-Reply-To: <401A8E0E.6090004@techsource.com>
Message-ID: <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no>
 <401A8E0E.6090004@techsource.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Timothy Miller wrote:

> > Another reason to drop VGA then - money.
> 
> As soon as PC BIOS's don't require it, we can drop it.

 No PC BIOS recognizes a VGA.  The PC/AT firmware uses int 0x10 to
communicate with the console and as long as there is a handler there,
console output works.  Most systems will actually run without a handler,
too, but they'll usually complain to the speaker.  The handler is provided
by the ROM firmware of the primary graphics adapter.

 Old PC/AT firmware actually did recognize a few display adapters, namely
the CGA and the MDA which had no own firmware.  These days support for
these option is often absent, even though the setup program may provide an
option to select between CGA40/CGA80/MDA/none (the latter being equivalent
to an option such as an EGA or a VGA, providing its own firmware).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
