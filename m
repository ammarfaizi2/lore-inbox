Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131607AbRCVEoz>; Wed, 21 Mar 2001 23:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131636AbRCVEoq>; Wed, 21 Mar 2001 23:44:46 -0500
Received: from munk.apl.washington.edu ([128.95.96.184]:27398 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S131607AbRCVEoa>; Wed, 21 Mar 2001 23:44:30 -0500
Date: Wed, 21 Mar 2001 20:40:21 -0800 (PST)
From: Brian Dushaw <dushaw@munk.apl.washington.edu>
To: <linux-kernel@vger.kernel.org>
Subject: VIA vt82c686b  and UDMA(100)
Message-ID: <Pine.LNX.4.30.0103212029540.3646-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Wisemen,
   I have been following the discussion of the VIA vt82c686b chipset
and the troubles people have had in getting UDMA(100) to work.  This
is to report that I have now tried the 2.4.2-ac20 kernel and the
2.2.18 kernel with Andre's patch (dated March 20) and neither of
them get the disk speed up to where it ought to be.  hdparm -t reports
back 11 MB/s or so for either kernel.
   VIA82CXXX enabled, and I also tried the ide0=ata66 flag, in desparation.
   At boot up both kernels report the disk as UDMA(100) - everything
seems to be peachy keen, but for the sluggish disk performance.

Merely a report from the front lines,

B.D.

