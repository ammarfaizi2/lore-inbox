Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUI0AVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUI0AVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 20:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUI0AVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 20:21:13 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:44047 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S265161AbUI0AVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 20:21:08 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C65@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "Randy.Dunlap" <rddunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Help Requested with patching "drivers/pci/quirks.c"
Date: Mon, 27 Sep 2004 12:20:30 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,
 
Thanks so much for your help.

> lspci -x -d 8086:24c3

OK, that (with the explanation of the values) helped a lot.  I've got a
subsystem vendor of 0e11 and subsystem device of 00b8.  I guess that
explains the values from "pcitweak -l", which where

PCI: 00:1f:3: chip 8086,24c3 card 0e11,00b8 rev 01 class 0c,05,00 hdr 00

As I said earlier, I'm willing to believe I had the information and didn't
recognise it; and I guess we confirmed that.

OK, now to patch and recompile the kernel, and see how we go....

If this works, I'll submit the patch for inclusion in "quirks.c" - I'll
leave it up to the appropriate maintainers to decide if they want it or
not....

Thanks again,

James Roberts-Thomson

LKML Readers:  Please ignore the following disclaimer - this email is
explicitly declared to be non confidential and does not contain privileged
information.


This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
