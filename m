Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSEGEzG>; Tue, 7 May 2002 00:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSEGEzF>; Tue, 7 May 2002 00:55:05 -0400
Received: from arcus.sinus.cz ([195.39.17.7]:44672 "EHLO arcus.sinus.cz")
	by vger.kernel.org with ESMTP id <S315337AbSEGEzE>;
	Tue, 7 May 2002 00:55:04 -0400
Date: Tue, 7 May 2002 06:55:01 +0200
From: Pavel Troller <patrol@sinus.cz>
To: linux-kernel@vger.kernel.org
Subject: Oops accessing CDROM on 2.5.1[1-4]
Message-ID: <20020507045501.GA15675@arcus.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
  I'm trying to run 2.5 series on the MSI K7D Master dual Athlon board with
AMD Opus chipset.
  From 2.5.11, the machine can boot, but it oopses instantly when I try
to mount a CD-ROM. I have an IDE burner so a SCSI emulation is used.
However, the oops seems to be in the IDE code so maybe it's not related.
The oops can be viewed at http://sinux.sinus.cz/~patrol/oops-2.5.txt .
  After this oops, machine continues to run (so it was possible to save
it) but about 20 seconds later a fatal oops in the swapper occurs, an
interrupt handler is killed and the machine halts.
  In 2.4.18, I can read from the CD, but an attempt to BURN the CD ends
up with destroyed CD, some SCSI errors and finally (also about 20 seconds
later) the fatal oops very similar to the one from 2.5.1x. The CD-RW
drive was formerly used with another MSI board with VIA chipset and there
it worked perfectly.
  Please CC: me directly in replies (if any), I'm not subscribed to the list.

                        With regards, Pavel Troller
