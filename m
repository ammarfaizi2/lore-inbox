Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130571AbQJ1QCw>; Sat, 28 Oct 2000 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQJ1QCc>; Sat, 28 Oct 2000 12:02:32 -0400
Received: from hoochie.linux-support.net ([216.207.245.2]:10512 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S130571AbQJ1QC2>; Sat, 28 Oct 2000 12:02:28 -0400
Date: Sat, 28 Oct 2000 11:02:22 -0500 (CDT)
From: Mark Spencer <markster@linux-support.net>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.0-test9 not Open Source
Message-ID: <Pine.LNX.4.21.0010281049300.26640-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at the MTD (memory technology device) additions to the
linux 2.4.0 kernels.  In particular I'm very interested in the DiskOnChip
2000 and NFTL drivers.  However, as terribly useful as this driver is, was
I the only one who caught the following notice at the top of the driver
source:

/*
  The contents of this file are distributed under the GNU Public
  Licence version 2 ("GPL"). The legal note below refers only to the
  _use_ of the code in some jurisdictions, and does not in any way
  affect the copying, distribution and modification of this code,
  which is permitted under the terms of the GPL.

  Section 0 of the GPL says:

 "Activities other than copying, distribution and modification are not
  covered by this License; they are outside its scope."

  You may copy, distribute and modify this code to your hearts'
  content - it's just that in some jurisdictions, you may only _use_
  it under the terms of the licence below. This puts it in a similar
  situation to the ISDN code, which you may need telco approval to
  use, and indeed any code which has uses that may be restricted in
  law. For example, certain malicious uses of the networking stack
  may be illegal, but that doesn't prevent the networking code from
  being under GPL.

  In fact the ISDN case is worse than this, because modification of
  the code automatically invalidates its approval. Modificiation,
  unlike usage, _is_ one of the rights which is protected by the
  GPL. Happily, the law in those places where approval is required
  doesn't actually prevent you from modifying the code - it's just
  that you may not be allowed to _use_ it once you've done so - and
  because usage isn't addressed by the GPL, that's just fine.

  dwmw2@infradead.org
  6/7/0

  LEGAL NOTE: The NFTL format is patented by M-Systems.  They have
  granted a licence for its use with their DiskOnChip products:

    "M-Systems grants a royalty-free, non-exclusive license under
    any presently existing M-Systems intellectual property rights
    necessary for the design and development of NFTL-compatible
    drivers, file systems and utilities to use the data formats with, 
    and solely to support, M-Systems' DiskOnChip products"

  A signed copy of this agreement from M-Systems is kept on file by
  Red Hat UK Limited. In the unlikely event that you need access to it,
  please contact dwmw2@redhat.com for assistance.  */


Now firstly, let's eliminate the ISDN red-herring from consideration
because the authors of the code do not place any additional restrictions
on the GPL whatsoever, they simply bring it to your attention that using
an un-certified ISDN stack may be illegal in some countries.

Now that we've cleared *that* up, let's look at the rest of the NFTL
restriction.  I've already brought this to the attention, of course, of
RMS and ESR.  

Richard believes that this violates the GPL because it places additional
restrictions not found in the GPL.

In any case, it seems pretty obvious that this restriction violates
section 6 of the Open Source Definition which states:

  "The license must not restrict anyone from making use of the program in
a specific field of endeavor...."

In this case, the field of endeavor is to use it with another vendor's
product.

In any case, as terribly useful as this driver is (I'm working on a system
that needs the Disk-On-Chip/NTFL support) I am also conerned with the
stock Linux kernel getting tainted with non-Open Source code.

Comments welcome and appreciated.

Mark

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
