Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUI0Wg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUI0Wg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUI0Wg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:36:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61865 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266200AbUI0WgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:36:25 -0400
Message-ID: <4158956F.3030706@engr.sgi.com>
Date: Mon, 27 Sep 2004 15:34:23 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: lse-tech <lse-tech@lists.sourceforge.net>, CSA-ML <csa@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>
Subject: [PATCH 2.6.9-rc2 0/2] enhanced accounting data collection
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an effort of providing an enhanced accounting data collection.

It is intended to offer common data collection method for various
accounting packages including BSD accouting, ELSA, CSA, and any other
acct packages that favor a common layer of data collection, separated
from data presentation layer and management of process groups layer.

This patchset consists of two parts: acct_io and acct_mm as we
identified useful spots for improved data collection in the area
of IO and MM.

This patchset is to replace the previously submitted CSA patchset
of four. The CSA kernel module is a standalone module. The csa_eop
patch was to provide a hook for end-of-process handling and that
can be considered separately unless there is enough common interest.

Now that the patchset is down to IO and MM, i hope it is more
appealing :)

Comments?

Best Regards,
  - jay
---
Jay Lan - Linux System Software
Silicon Graphics Inc., Mountain View, CA

