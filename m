Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUAMNH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 08:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUAMNH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 08:07:59 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:44720 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264256AbUAMNH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 08:07:58 -0500
Date: Tue, 13 Jan 2004 14:07:54 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
In-Reply-To: <20040113022826.GC1646@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Ralf Baechle wrote:

> > it seems the following is required in Linus' tree to get correct depends 
> > for DECSTATION:
> 
> Thanks,  applied.

 The dependency was intentional: stable for 32-bit, experimental for
64-bit.  I'm reverting the change immediately.  Please always contact me
before applying non-obvious changes for the DECstation.

 If there's anything wrong with the depends, it should be fixed elsewhere.  
Details, please.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
