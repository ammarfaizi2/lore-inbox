Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbUCUSI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUCUSI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:08:58 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:15747 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263682AbUCUSIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:08:43 -0500
Date: Sun, 21 Mar 2004 12:59:12 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Updates for 2.6.5-rc2
Message-ID: <20040321125912.GA3213@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This release contains ISAPnP fixes, parport_pc device detection improvements, 
and other random fixes.  All of these patches have been in the -mm tree for 
testing.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.6

Thanks,
Adam

 drivers/parport/parport_pc.c |  100 ++++++++++++++++++++++++++++++-------------
 drivers/pnp/isapnp/Kconfig   |    4 -
 drivers/pnp/isapnp/core.c    |   18 +++----
 drivers/pnp/resource.c       |   10 ----
 drivers/pnp/system.c         |    4 -
 drivers/serial/8250_pnp.c    |    6 ++
 6 files changed, 91 insertions(+), 51 deletions(-)
-------

Adam Belay:
  o [ISAPNP] Unmark experimental status
  o [PNP] Add some more modem IDs
  o [ISAPNP] MEM Config Fix
  o [ISAPNP] Fix Device Detection Issue
  o [PARPORT] Update PC Parport Detection Code

Christoph Hellwig:
  o [ISAPNP] Remove uneeded MOD_INC/DEC_USE_COUNT

Matthew Wilcox:
  o [PNP] Resource Conflict Cleanup

Randy Dunlap:
  o [PNP] remove __init from system.c
