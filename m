Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVHCIEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVHCIEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 04:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVHCIEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 04:04:33 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:25748 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262140AbVHCICx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 04:02:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Interbench v0.26
Date: Wed, 3 Aug 2005 17:58:31 +1000
User-Agent: KMail/1.8.1
Cc: ck@vds.kolivas.org, Peter Williams <pwil3058@bigpond.net.au>,
       Jake Moilanen <moilanen@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031758.31246.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This benchmark application is designed to benchmark interactivity in Linux.

Direct download link:
http://ck.kolivas.org/apps/interbench/interbench-0.26.tar.bz2

Web site:
http://interbench.kolivas.org

Changes since v0.24:

v0.25:
The timekeeping thread of background load no longer runs SCHED_FIFO. The 
benchmark is allowed to proceed if it does not detect swap and instead 
disables mem_load. The documentation was updated.

v0.26:
Fixed the standard deviation measurements at last (thanks Peter Williams). 
There should be no practical limit to how long you can run a benchmark for 
now.

Cheers,
Con
