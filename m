Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbRBIEPC>; Thu, 8 Feb 2001 23:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbRBIEOx>; Thu, 8 Feb 2001 23:14:53 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:28604 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S129866AbRBIEOp>; Thu, 8 Feb 2001 23:14:45 -0500
To: linux-kernel@vger.kernel.org
Subject: paging question
Reply-To: Daniel Stodden <stodden@in.tum.de>
From: Daniel Stodden <stodden@informatik.tu-muenchen.de>
Message-ID: <87elx81omm.fsf@bitch.localnet>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 9 Feb 2001 05:14:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

i desperately hope this is not too stupid.

i'm trying to write a driver which depends on giving pci devices
access to somewhat larger amounts of pysical memory. let's say, a
megabyte of contiguous ram.

is it possible to resize such an area later on? i mean: is there some
mechanism available in the kernel to enlarge such a region even if the
area beyond it is already in use?

i understand that this is pretty impossible if some entity depends on
correct physical locations of the pages in question. but couldn't for
example userland memory be copied elsewhere and its new location
simply remapped?

regards,
dns

-- 
___________________________________________________________________________
 mailto:stodden@in.tum.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
