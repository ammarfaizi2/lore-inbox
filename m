Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbUCTOa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbUCTOa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:30:59 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:39135 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263422AbUCTOaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:30:55 -0500
Subject: [BK PATCH] essential SCSI fixes for 2.6.5-rc2
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Mar 2004 09:30:46 -0500
Message-Id: <1079793048.1778.6.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the two oops related fixes from the scsi-misc-2.6 tree that
testing has shaken out.  They are available at

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The shortlog is:



Brian King:
  o SCSI: Fix Oops in sg with lots of SG_IO activity

Kai Mäkisara:
  o Fix SCSI + st regressions problem


And the diffstat:

 sg.c |    4 ++--
 st.c |   15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

James


