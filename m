Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLGOGc>; Thu, 7 Dec 2000 09:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130153AbQLGOGX>; Thu, 7 Dec 2000 09:06:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129477AbQLGOGE>; Thu, 7 Dec 2000 09:06:04 -0500
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
To: proski@gnu.org (Pavel Roskin)
Date: Thu, 7 Dec 2000 13:37:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, perex@suse.cz (Jaroslav Kysela),
        zaitcev@metabyte.com (Pete Zaitcev), peter@cadcamlab.org,
        kai@thphy.uni-duesseldorf.de
In-Reply-To: <Pine.LNX.4.30.0012061254420.1411-100010@fonzie.nine.com> from "Pavel Roskin" at Dec 06, 2000 01:12:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1441FJ-0002QX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Linux-sound list appears to be dead (I don't see my message in
> http://www.kernelnotes.org/lnxlists/linux-sound/), so I'm sending to the

sound-list@redhat.com is alive and well however.

> An additional problem is that opl3 cannot find the device unless I load
> and unload the old driver (ymf_sb). Probably the new driver should put the
> OPL3 interface to the legacy mode if it cannot handle it directly.

Probably

> Dec  5 18:08:16 fonzie kernel: ymfpci: ioctl cmd 0x5401
> Dec  5 18:08:50 fonzie last message repeated 9 times

Just debugging this is fine

> $ play spinout.wav
> sox: Unable to set audio speed to 5512 (set to 8000)

8Khz is the lower limit right now the way the board is driven.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
