Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRCTKna>; Tue, 20 Mar 2001 05:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRCTKnU>; Tue, 20 Mar 2001 05:43:20 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:20915 "EHLO
	inet-smtp4.oracle.com") by vger.kernel.org with ESMTP
	id <S129446AbRCTKnK>; Tue, 20 Mar 2001 05:43:10 -0500
Message-ID: <3AB732F0.CE13E52F@oracle.com>
Date: Tue, 20 Mar 2001 11:37:36 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to repost the issue but I got no reply...

 2.4.3-pre3 and synced-up versions of the -ac series remove support for
 PCMCIA serial CardBus. In drivers/char/pcmcia the Makefile and Config.in
 files are modified to exclude serial_cb and the serial_cb.c file itself
 is removed by the patch. As a net result, my Xircom modem port becomes
 invisible to the kernel and I can't dial out through it.

As a temporary measure I backed out the changes in drivers/char/pcmcia
 and my 2.4.3-pre4 kernel seems happy (in fact I am dialing out through
 said Xircom modem).

Did I miss some announcement for replacement features for serial_cb or
 did a bad patch slip in ?


Thanks & ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p17/2.4.3p4 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
