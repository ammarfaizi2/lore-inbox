Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUCZJHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbUCZJHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:07:14 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263983AbUCZJHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:07:05 -0500
Date: Fri, 26 Mar 2004 09:09:47 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403260909.i2Q99lfP000507@81-2-122-30.bradfords.org.uk>
To: "David Schwartz" <davids@webmaster.com>, <debian-devel@lists.debian.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com>
Subject: RE: Binary-only firmware covered by the GPL?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	What does it matter what it compiles under? The GPL is not Linux-specific.

Actually, it matters quite a lot.  If the firmware was written in
assembler, and assembled with a non-free, proprietary compiler, which
doesn't use standard assembley syntax, then maybe for people who are
familiar with the CPU, and refuse to use proprietrary software, the
machine code is the preferred form.

Note that the GPL refers to the preferred form for making
_modifications_, not the preferred form for writing the code from
scratch.

For example, suppose I made a simple wristwatch based on a Z80.  It's
possible that I might write the original firmware in assembley, and
assemble it on another machine, (although it's probably just as likely
that I'd use a pen and paper, assemble it by hand).  However, if I
found a bug some time later, or wanted to make any simple changes, I'd
probably just disassemble the machine code and patch it manually.

For highly embedded devices, the preferred form for making
modifications doesn't necessarily mean the form it was originally
written in.

> 	If you don't have the preferred form of something for the purpose of making
> modifications to it, then you can't give that to people, so you *CAN'T* GPL
> it.

Err, surely that only applies if your rights to the thing were
already _granted_ to you under the GPL, and the 'preferred form' has
already been established.

For example, if I write a C program, and gives you the source under
the GPL, the source is obviously the preferred form for making
modifications.

If, however, I write a C program, compile it, and put the binary and
source in to the public domain, and years later all copies of the
source have been lost, I don't see why somebody obtaining the binary,
which has been placed in the public domain, couldn't disassemble it,
read and understand it, add comments to the assembler source
explaining how it works, and place the resulting work under the GPL.

Another example - if I code something, the chances are that it won't
have any indenting, and the variable names will either be arbitrary
letters, or one or two letter abbreviations of the things they stand
for.  That is my prefered form of making modifications to my own
code.  If I then placed the code under the GPL, there is no
requirement for me to indent it, just because the majority of
developers would prefer that form for making modifications.

John.
