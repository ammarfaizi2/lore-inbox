Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUBBXhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBBXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:37:41 -0500
Received: from www1.proofpoint.com ([207.111.236.2]:28402 "EHLO
	mail.us.proofpoint.com") by vger.kernel.org with ESMTP
	id S261506AbUBBXhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:37:39 -0500
Subject: broken maxcpus in 2.4.24
From: Dan Christian <dac@proofpoint.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075765034.17943.79.camel@reactor.us.proofpoint.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 02 Feb 2004 15:37:14 -0800
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Score: mlxscore=0 adultscore=50 adjust=0 score=0 rule=notspam version=2.0.0-04012200 mlxdetails="spam=0.00152511832388382,adult=0.5,sa=0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled a vanilla 2.4.24 for a 2 processor Xeon.  

I set CONFIG_NR_CPUS to 4 (2 CPUs x 2 hyperthreads each).

When I boot the kernel, /proc/cpuinfo only shows 2 cpus (0-1) and
performance is bad.

I reconfigure CONFIG_NR_CPUS back to 32.  Now it shows 4 cpus (0-3) and
performance is normal.

Is this a bug or am misunderstanding how to set this configuration
variable?

-Dan Christian


