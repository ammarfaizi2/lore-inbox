Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbUAMRC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUAMRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:02:27 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:46505 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264418AbUAMRC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:02:26 -0500
Date: Tue, 13 Jan 2004 18:02:22 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
In-Reply-To: <20040113163934.GB31459@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401131752380.3158@jurand.ds.pg.gda.pl>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org>
 <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
 <20040113163934.GB31459@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Ralf Baechle wrote:

> >  The dependency was intentional: stable for 32-bit, experimental for
> > 64-bit.  I'm reverting the change immediately.  Please always contact me
> > before applying non-obvious changes for the DECstation.
> 
> Well, this one seemed to be obvious but sometimes things are not what
> they seem to be ...

 Hmm, a change of semantics wouldn't qualify as obvious for me...

 I admit this construct may seem surprising at first sight when compared
to many other uses of EXPERIMENTAL -- the equivalent more verbose syntax
used for 2.4 leaves no doubt about the intent, though.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
