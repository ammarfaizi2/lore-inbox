Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUBHQPP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUBHQPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:15:15 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:31643 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263771AbUBHQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:15:09 -0500
Subject: [BK PATCH] bug fixes for scsi for linux-2.6.3-rc1
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Feb 2004 11:14:54 -0500
Message-Id: <1076256895.2055.6.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BK tree at

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

contains four bugfixes for the previous update (actually allow the
qla2xxx to build as part of the build process and remove its compile
warnings, fix the mptscsih_exit() discard problem and undelete the
qlogicfc driver).

The short changelog is:

Andrew Morton:
  o Fix qla2xxx warnings

Andrew Vasquez:
  o qla2xxx Kconfig fix

James Bottomley:
  o mpt fusion fix mptscsih_exit() discard
  o SCSI: undelete qlogicfc driver


James


