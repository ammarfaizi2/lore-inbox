Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbREMGgB>; Sun, 13 May 2001 02:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261382AbREMGfv>; Sun, 13 May 2001 02:35:51 -0400
Received: from equinox.unr.edu ([134.197.1.2]:5324 "EHLO equinox.unr.edu")
	by vger.kernel.org with ESMTP id <S261381AbREMGfm>;
	Sun, 13 May 2001 02:35:42 -0400
From: Eric Olson <ejolson@unr.edu>
Message-Id: <200105130635.f4D6ZWX10800@equinox.unr.edu>
Subject: FastTrack100+2.4.4 panic
To: linux-kernel@vger.kernel.org
Date: Sat, 12 May 2001 23:35:32 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having trouble with the 2.4.4 kernel using MSI 694D Pro AR dual
PIII processor motherboard with onboard Promise ATA100.

I have four nearly identically configured motherboards, two of which
have the Promise ATA100 and two which do not.  There are no disks
hooked to the Promise controller and I am not using it.  However, the
motherboards with the Promise controller panic soon after the Promise
detection lines

PDC20265: IDE controller on PCI bus 00 dev 60
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later

with something like a null pointer reference.  I'm sorry not to have
the panic decoded and the message in details.  The 2.4.3 kernel boots
and runs fine on all systems.  The 2.4.4 kernel panics on systems 
with the Promise controller but runs fine on the systems without it.

I'll look at it more tomorrow.  I will be satisfied simply disabling 
the detection of the Promise controller since I'm not using and have 
never used it anyway.  However, I thought this change of behaviour 
between 2.4.3 and 2.4.4 for the MSI 694 Pro AR might be interesting.

Does anyone else have this ideas about this?

--Eric
