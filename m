Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbSLMAE3>; Thu, 12 Dec 2002 19:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbSLMAE3>; Thu, 12 Dec 2002 19:04:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28166 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267544AbSLMAE1>;
	Thu, 12 Dec 2002 19:04:27 -0500
Message-ID: <3DF925AC.4020703@pobox.com>
Date: Thu, 12 Dec 2002 19:11:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: [PATCH 2.4.20] vanilla 3c59x
Content-Type: multipart/mixed;
 boundary="------------020908010405090006090002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020908010405090006090002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch, against 2.4.20, updates 3c59x to vanilla Don Becker version 
that is available at ftp://www.scyld.com/pub/network/3c59x.c

It's too big post on a list, so I put it up at
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.20/3c59x-vanilla-2.4.20.patch.gz

It's also available from BitKeeper at the 'bk pull' URL attached to this 
email.  But be warned you are pulling from 2.4.21-bk-current, plus 
3c59x.c changes, not vanilla 2.4.20 as the patch is diff'd against.

--------------020908010405090006090002
Content-Type: text/plain;
 name="3c59x-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c59x-2.4.txt"


	bk pull bk://kernel.bkbits.net/jgarzik/3c59x-2.4

This will update the following files:

 drivers/net/3c59x.c       | 3254 +++++++++++++++++++---------------------------
 drivers/net/Makefile      |    2 
 drivers/net/kern_compat.h |  284 ++++
 drivers/net/pci-scan.c    |  658 +++++++++
 drivers/net/pci-scan.h    |   90 +
 5 files changed, 2440 insertions(+), 1848 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (02/12/12 1.812)
   [netdrvr 3c59x] update to vanilla Becker version 0.99Xf (11/17/2002)


--------------020908010405090006090002--

