Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267987AbTBMHrp>; Thu, 13 Feb 2003 02:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTBMHrp>; Thu, 13 Feb 2003 02:47:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55559 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267987AbTBMHro>;
	Thu, 13 Feb 2003 02:47:44 -0500
Message-ID: <3E4B4FD0.5090807@pobox.com>
Date: Thu, 13 Feb 2003 02:57:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] net driver fixes
Content-Type: multipart/mixed;
 boundary="------------080504020602070608060604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080504020602070608060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080504020602070608060604
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/amd8111e.c        |    2 +-
 drivers/net/arlan.c           |    2 +-
 drivers/net/fc/iph5526.c      |    2 +-
 drivers/net/tg3.c             |    7 +++++--
 drivers/net/tokenring/smctr.c |    2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/02/13 1.1037)
   [netdrvr arlan] fix the fixed fix. really.
   
   struct arlan_private clearly needs to be a pointer.

<jgarzik@redhat.com> (03/02/13 1.1036)
   [netdrvr tg3] DMA MRM bit only exists on 5700, 5701
   
   Fixed by David Miller, spotted by Manish Lachwani.

<jgarzik@redhat.com> (03/02/13 1.1035)
   [netdrvr amd8111e] remove stray ';', fixing register dump [#311]
   
   Fixes bugzilla bug #311.

<jgarzik@redhat.com> (03/02/13 1.1034)
   [tokenring smctr] remove stray ';' that prevented a loop from working [#312]
   
   Fixes broken node address check, and bugzilla bug #312.

<jgarzik@redhat.com> (03/02/13 1.1033)
   [netdrvr fc/iphase] correct PCI probe loop-end test logic [#323]
   
   Fixes bugzilla bug #323.


--------------080504020602070608060604--

