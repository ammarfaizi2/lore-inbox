Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270042AbRHMJge>; Mon, 13 Aug 2001 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270051AbRHMJgO>; Mon, 13 Aug 2001 05:36:14 -0400
Received: from polypc17.chem.rug.nl ([129.125.25.92]:37784 "EHLO
	polypc17.chem.rug.nl") by vger.kernel.org with ESMTP
	id <S270042AbRHMJgL>; Mon, 13 Aug 2001 05:36:11 -0400
Date: Mon, 13 Aug 2001 11:36:23 +0200 (CEST)
From: "J.R. de Jong" <jdejong@chem.rug.nl>
To: linux-kernel@vger.kernel.org
Subject: RZ1000 chipset support/bugfix broken in 2.4.x
Message-ID: <Pine.LNX.4.21.0108131122400.32539-100000@polypc17.chem.rug.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since I'm not a member of the list, I would appreciate it if people would
cc me if sending a reply.

I have encountered a problem with RZ1000 chipset support/bugfix in
2.4.8. I recently tried upgrading my old Pentium firewall, which has this
chipset, from 2.2.19 to 2.4.8 because of the new netfilter
support.

However, with RZ1000 support enabled the kernel did not detect my 
harddrives. Without it they do get detected, but then I have to work
around the prefetch bug by disabeling IDE prefetch in the BIOS. Moreover
the kernel complains about RZ1000 being handled by a seperate driver and
about ignoring the RZ1000 interface. 

The ATA configuration in whe working/non-working cases are:

working:
* Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
* Include IDE/ATA-2 DISK support
M Include IDE/ATAPI CDROM support
* Generic PCI IDE chipset support

non working:
working +
* RZ1000 chipset bugfix/support

Have I stumbled across a real bug here, or am I just plain stupid ;)

Note that this setup used to work with 2.2.19.

Regards,

Johan.


