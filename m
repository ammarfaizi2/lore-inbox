Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266829AbUBGKEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 05:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUBGKEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 05:04:11 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:26856 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266829AbUBGKEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 05:04:09 -0500
Date: Sat, 7 Feb 2004 11:04:07 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Josh McKinney <forming@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
In-Reply-To: <20040207063906.GA2188@forming>
Message-ID: <Pine.LNX.4.55.0402071100550.12260@jurand.ds.pg.gda.pl>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
 <4022B55B.1090309@wanadoo.es> <20040205154059.6649dd74.akpm@osdl.org>
 <Pine.LNX.4.55.0402070021210.12260@jurand.ds.pg.gda.pl> <20040207035018.33ce01dc.ak@suse.de>
 <20040207063906.GA2188@forming>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Josh McKinney wrote:

> I tried the patch against 2.6.3-rc1 and it doesn't seem to fix
> anything, timer is still on XT-PIC.  This is on a A7N8X Deluxe rev2,
> nforce2.

 The patch fixes our bad interpretation of the ACPI spec -- it's not 
sufficient to work around errors in the nforce2's ACPI tables, which 
should really get fixed by the manufacturer with a BIOS update.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
