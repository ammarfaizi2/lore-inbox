Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWE0UHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWE0UHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWE0UHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:07:21 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:30437 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964932AbWE0UHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:07:20 -0400
Subject: [GIT PATCH] scsi bug fixes for 2.6.17-rc5
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 27 May 2006 13:07:11 -0700
Message-Id: <1148760432.3890.4.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my current slew of small bug fixes which either fix serious
bugs, or are completely safe for this -rc5 stage of the kernel.

The patch is available from:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Eric Moore:
  o scsi_transport_sas: make write attrs writeable

James Bottomley:
  o scsi_transport_sas; fix user_scan
  o mptspi: reset handler shouldn't be called for other bus protocols

Randy.Dunlap:
  o ppa: fix for machines with highmem

Thomas Bogendoerfer:
  o Blacklist entry for HP dat changer

And the diffstat:

 message/fusion/mptbase.c  |   27 +++++++++++++++++++++------
 scsi/ppa.c                |    7 +++++++
 scsi/scsi_devinfo.c       |    1 +
 scsi/scsi_transport_sas.c |    4 ++--
 4 files changed, 31 insertions(+), 8 deletions(-)

James


