Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264785AbUEER2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264785AbUEER2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEER2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:28:18 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:10632 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264788AbUEER2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:28:13 -0400
Subject: SATA DVD in Linux, apparently not yet
From: Pat LaVarre <p.lavarre@ieee.org>
To: kernelnewbies@nl.linux.org
Content-Type: text/plain
Organization: 
Message-Id: <1083778065.3139.5.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2004 11:27:45 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2004 17:28:12.0303 (UTC) FILETIME=[575099F0:01
	C432C6]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:6.31638 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After plugging in a SATA DVD and seeing it not work:

$ uname -srvm
Linux 2.6.5 #4 SMP Mon Apr 19 14:52:26 MDT 2004 i686
$
$ sudo less /var/log/messages
...
Assertion failed! dev->class == ATA_DEV_ATA,drivers/scsi/libata-core.c,ata_dev_parse_strings,line=695
...
$

My failures to understand this result I may blog to:

http://linux-pel.blog-city.com/read/597910.htm

My successes I may summarise back here.

Pat LaVarre
bc: linux-kernel@vger.kernel.org


