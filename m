Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUDGJI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 05:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUDGJI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 05:08:27 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:5853 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261795AbUDGJIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 05:08:25 -0400
Date: Mon, 5 Apr 2004 15:15:33 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
In-Reply-To: <20040404101241.A10158@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0404051504080.31851@jurand.ds.pg.gda.pl>
References: <20040404101241.A10158@flint.arm.linux.org.uk>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004, Russell King wrote:

> Since we have drivers/serial/dz.[ch] now merged, is there a reason to
> keep drivers/char/dz.[ch] around any more?  I notice people keep doing
> cleanups, but this is wasted effort if the driver is superseded by the
> new drivers/serial/dz.[ch] driver.

 drivers/char/dz.[ch] has been verified to work on real hardware, at least 
with 2.4.  Can the same be said of drivers/serial/dz.[ch]?  If so, then 
the former can be removed from the mainline.

 Anyway, I plan a functional update to drivers/char/dz.[ch], to add
missing features that should have made their way there for 2.4.  Then I'll
see what needs to be ported to drivers/serial/dz.[ch] and update it
accordingly.  Only then I'll consider the former to be in a strict bugfix
mode.  Updates to the old driver can be done solely in the MIPS 2.4 tree,
though.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
