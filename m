Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUL0B1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUL0B1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUL0B1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:27:54 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:29847 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S261611AbUL0B1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:27:50 -0500
Mime-Version: 1.0
Message-Id: <a06100509bdf510e81b8b@[129.98.90.227]>
Date: Sun, 26 Dec 2004 20:27:21 -0500
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Why is the kernel complaining about large SCSI LUNs
Cc: patmans@us.ibm.com, ericy@cais.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel 2.6.9 on an Opteron box with an LSI 320 card and 
am seeing the following message repeatedly in dmesg:

scsi: host 1 channel 0 id 0 lun 0x5a5a5a5a5a5a5a5a has a LUN larger 
than currently supported.

Is this just cosmetic or there is a bug somewhere? It appears that 
scsi_scan.c has logic where this message is actually valid, but how 
can that be?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
