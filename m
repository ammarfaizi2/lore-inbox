Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311459AbSCNBCv>; Wed, 13 Mar 2002 20:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311460AbSCNBCm>; Wed, 13 Mar 2002 20:02:42 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:54159 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S311459AbSCNBCb>; Wed, 13 Mar 2002 20:02:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 13 Mar 2002 17:02:24 -0800
Message-Id: <200203140102.RAA05788@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> NCR drivers in 2.4.18 and 2.5.6, but looking at the changes with
>> "diff -w" shows very few other changes, just really ancilliary
>> things like option parsing.

>That sounds like its some half step

	I think I may have gotten confused here.  Are you only
talking about the NCR53*80* drivers (pas16, seagate, t128,
dmx3191, dtc), or the '80 and the '9x drivers (NCR53C9x.c,
blz1230, bzl2060, cyberstorm, cyberstormII, dec_esp, fastlane,
jazz_esp, mac_esp, mac_53c9x, oktago_esp, sun3x_esp), or both?

	NCR5380.c in 2.4.18 and 2.5.7-pre1 are identical files,
as is NCR5380.h.  If those are the only files that you were
talking about being reverted/upgraded, then my statements
about the diffs were in error, and I apologize for the confusion.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
