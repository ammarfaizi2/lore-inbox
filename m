Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUGRVwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUGRVwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 17:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUGRVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 17:52:21 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:54449 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264531AbUGRVwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 17:52:20 -0400
Date: Sun, 18 Jul 2004 23:52:01 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: rsync out of memory 2.6.8-rc2
Message-ID: <20040718215201.GA840@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: r1dWHiZdwe4n1V3vmD5daBGTUbQaoIPZIXF5wzTk8qJf3B4vQEY7r7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rsync-2.6.2 of a large disc using 2.6.8-rc2 (I also tried 2.6.7-bk14)
stops with "kernel: Out of Memory: Killed process xxxx" messages
during filelist gathering.

When this happens only 1.4 GB out of 2 GB RAM and no swap is used.

No problems with kernel 2.6.7.
(Peak RAM usage during filelist gathering was 1.8 GB, no swap)

--
Klaus

