Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVBFSDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVBFSDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVBFSDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:03:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51842
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261261AbVBFSDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:03:14 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc3
Date: Sun, 6 Feb 2005 12:00:33 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>
References: <200502051051.46242.rob@landley.net> <420509D1.2080401@tuxrocks.com>
In-Reply-To: <420509D1.2080401@tuxrocks.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502061200.33755.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 01:00 pm, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Rob Landley wrote:
> | As of yesterday afternoon, the UML build still breaks in
> | sys_call_table.c,
...
> This patch for sys_call_table.c was merged into the main tree in this
> changeset:
> http://linux.bkbits.net:8080/linux-2.5/cset@1.2080?nav=index.html|ChangeSet
>@-2d
>
> The patch fixes both the sys_call_table and the pud_alloc breakage, and
> as of 2.6.11-rc3-bk2, the main tree compiles again for UML.

Verified.  2.6.11-rc3-bk2 does indeed build, and the result is chugging 
through my big compile script.  It seems to be working fine, although ye olde 
display glitch is still there:

binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.rd
binutils-2.14/ld/testsuite/lde/ld-/ld-sld-spd-spa-sparsparcparc/arc/trc/tlc/tls/tlsstlssulssunssunbsunbiunbinnbin6bin64in64.n64.s64.s4.s.ss
binubinutinutinutilutilstils-ils-2ls-2.s-2.1-2.142.14/.14/l14/ld4/ld//ld/tld/ted/tes/testtestsestsustsuitsuitsuiteuite/ite/lte/lde/ld-/ld-sld-spd-spa-sparsparcparc/tlssunbin64.sd
binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.td

But that's a purely cosmetic bug.

Thanks,

Rob
