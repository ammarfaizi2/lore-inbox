Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266948AbUAXPKN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266949AbUAXPKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:10:12 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:8130 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266948AbUAXPKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:10:07 -0500
Subject: [BK PATCH] small SCSI fixes for 2.6.2-rc1
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Jan 2004 10:09:56 -0500
Message-Id: <1074957001.2660.3.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically just an assortment of small warnings, doc changes and
API conformancy updates (it also includes the parallel build fix for
aic7xxx which has been annoying the OSDL builds).

The patch is here:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

and the short changelog is:

Andrew Morton:
  o aha1542 warning fix

James Bottomley:
  o aic7xxx parallel build
  o drivers/scsi/Kconfig URL update: resource.cx

Mark Haverkamp:
  o Fix for aacraid and high memory on 2.6.1

The diffstat is

 Kconfig                 |    2 -
 aacraid/aacraid.h       |    8 ++++++
 aacraid/linit.c         |   56 +++++++++++++++++++++++++++++++-----------------
 aha1542.c               |    4 +--
 aic7xxx/Makefile        |   16 ++++++++++++-
 aic7xxx/aicasm/Makefile |    8 ++++++
 6 files changed, 71 insertions(+), 23 deletions(-)

James


