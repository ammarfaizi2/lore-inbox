Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVAXUUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVAXUUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVAXUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:20:19 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:6377 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261618AbVAXUTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:19:15 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200501242019.j0OKJExO009851@clem.clem-digital.net>
Subject: pre 2.6.11 Memory Leak -- data
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Mon, 24 Jan 2005 15:19:14 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.9765.1106597954--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.9765.1106597954--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some data collected using VMware 4.5.2 (with Petr's patch 89) which maybe
can help track down the memory problem. This is with 2.6.11-rc2-bk2. Took
little over an hour for the system to start moving into swap.

Attached gzipped tar file contains 11 files.
log which is output of vmstat -a 600
meminfo1 thru 5
slabinfo 1 thru 5
  1 is prior to starting a VMware guest, short after a fresh boot. 
  2 is just after starting a VMware guest. Guest has 128MB assigned.
  3 is just after system start to show swap usage. System never normally
    requires any swap.
  4 is just prior to exiting the VMware guest.
  5 is after VMware guest closed out.

-- 
Pete Clements 



--%--multipart-mixed-boundary-1.9765.1106597954--%
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Description: gzip compressed data, deflated, last modified: Mon Jan 24 14:54:24 2005, os: Unix
Content-Disposition: attachment; filename="data.taz"

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

--%--multipart-mixed-boundary-1.9765.1106597954--%--
