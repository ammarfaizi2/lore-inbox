Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310838AbSCMRST>; Wed, 13 Mar 2002 12:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310840AbSCMRSJ>; Wed, 13 Mar 2002 12:18:09 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:41146 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310838AbSCMRRy>; Wed, 13 Mar 2002 12:17:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 13 Mar 2002 09:17:52 -0800
Message-Id: <200203131717.JAA09703@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...] A general give away that you have the right one is that
>they are formatted to the linux CodingStyle document.

>Alan

	Actually, there are many indentation changes between the
NCR drivers in 2.4.18 and 2.5.6, but looking at the changes with
"diff -w" shows very few other changes, just really ancilliary
things like option parsing.

	I was a little surprised to see things like procedure
declaration lines ending in "{", which I understand confuses vi
(or some vi's).  Examples from g_NCR53C80.c include internal_setup,
generic_NCR5380_setup, generic_NCR53C400_setup, and many others.

	I believe the code in 2.5.6 is your new NCR driver,
in spite of the formatting differences.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
