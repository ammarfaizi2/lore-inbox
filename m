Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTLOMtI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTLOMtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:49:08 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:46552 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263593AbTLOMtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:49:06 -0500
Date: Mon, 15 Dec 2003 13:49:04 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ross.alexander@uk.neceur.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <OFAC3015E2.784FA52E-ON80256DFD.003A2DB1-80256DFD.003C2F2D@uk.neceur.com>
Message-ID: <Pine.LNX.4.55.0312151347040.26565@jurand.ds.pg.gda.pl>
References: <OFAC3015E2.784FA52E-ON80256DFD.003A2DB1-80256DFD.003C2F2D@uk.neceur.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 ross.alexander@uk.neceur.com wrote:

> 2) If the local apic is running is it necessary to use the 8254 as a 
> timer?

 The 8254 timer is used for timekeeping -- it would be unnecessarily ugly 
to stuff this fuctionality to the APIC timer on one of CPUs.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
