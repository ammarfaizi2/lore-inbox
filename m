Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbTLROcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbTLROcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:32:55 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:39345 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265193AbTLROcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:32:43 -0500
Date: Thu, 18 Dec 2003 15:32:41 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <200312181130.46881.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0312181525070.23601@jurand.ds.pg.gda.pl>
References: <200312180414.17925.ross@datscreative.com.au> <3FE0CF41.9000706@mvista.com>
 <200312181130.46881.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Ross Dickson wrote:

> I grabbed the manuals that google search found.  By the look of it what I had
> covered P3 and earlier. Yours are more up to date and cover P4.

 Newer manuals sometimes lack details that are present in older ones.  If
you want to have a thorough view of the APIC, you certainly want to have
all four variations of processor manuals, i.e. the one for P4+, the one
for PII+, the one for PPro and the one for Pentium.  Plus manuals for the
I/O APIC, e.g. the one for the i82093AA and perhaps for ones embedded into
various chipsets.  All of them are or used to be available online.  If you
want to go back to the i82489DX, there is a datasheet and a programming
manual for the part, which are IMO the most exhaustive descriptions,
though the implementation differed a bit from newer ones (the chip was so
far the most powerful implementation of the APIC).  These were
unfortunately never available online.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
