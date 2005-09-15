Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVIOAjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVIOAjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:39:37 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:42946 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932495AbVIOAjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:39:36 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: Query: DE-600 parallel port NIC
Date: Thu, 15 Sep 2005 10:39:23 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <k7fhi1tfivq2cb09q8ku14l79o2oi3dqiv@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Been trying to get D-Link DE-600 portable parallel port adaptor 
going, on 2.4 it is detected but cannot claim the interrupt, on 
2.6.13+ it says the port is busy.


On both kernels I need to turn on ISA to make the NIC visible, 
that's easy to fix and a patch sent recently.  But I wonder what 
other traps & pitfalls to expect?

The DE-600 works under win98se in the target laptop[1] with win95 
driver, is detected (minus irq) in another box [2] with 2.4.31-hf5.

[1] http://bugsplatter.mine.nu/test/boxen/tosh/
[2] http://bugsplatter.mine.nu/test/boxen/sempro/

Thanks,
Grant.

