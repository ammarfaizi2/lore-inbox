Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRCPBVg>; Thu, 15 Mar 2001 20:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRCPBV2>; Thu, 15 Mar 2001 20:21:28 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:30938 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S129440AbRCPBVM>; Thu, 15 Mar 2001 20:21:12 -0500
Message-ID: <3AB1695F.222AB63F@oracle.com>
Date: Fri, 16 Mar 2001 02:16:15 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre3 and further ate PCMCIA serial cardbus support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fact this -pre4 works only after reverting the changes to Config.in,
 Makefile and serial_cb.c in drivers/char/pcmcia, otherwise my Xircom
 modem wouldn't be seen (tulip Ethernet is okay). -pre2 is fine.

So - was there any announcement about something like serial_cs engulfing
 serial_cb or is it just a bad patch that slipped in ?


Thanks & ciao,
 
--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p16/2.4.3p4 glibc-2.2 gcc-2.96-69 binutils-2.10.91.0.4
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
