Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTLOOSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLOOSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:18:17 -0500
Received: from ANancy-107-1-3-152.w80-15.abo.wanadoo.fr ([80.15.34.152]:31673
	"EHLO joebar.freealter.fr") by vger.kernel.org with ESMTP
	id S263596AbTLOOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:18:16 -0500
Date: Mon, 15 Dec 2003 15:17:46 +0100
To: linux-kernel@vger.kernel.org
Subject: Simple partition not detected with 2.6
Message-ID: <20031215141746.GA27006@joebar.freealter.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ludovic Drolez <ludovic.drolez@linbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have one computer which has two partitions per disk.
This partition is seen by a 2.4.xx kernel (knoppix) but
not by a 2.6.0t7 kernel.

When booting the knoppix, dmesg says:

hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63
ide-cd: passing drive hde to ide-scsi emulation.
Partition check:
hda: [PTBL] [9729/255/63] hda1 hda2
hdc: [PTBL] [9729/255/63] hdc1 hdc2


But the 2.6.0t7 does not see the partition table. 
Other disks are properly recognized, so it seems to
be a problem with [PTBL] and 2.6 ...

Any clues ?

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26
