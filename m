Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUDNUyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUDNUyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:54:06 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:57476 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261704AbUDNUyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:54:02 -0400
Date: Wed, 14 Apr 2004 04:54:43 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Fixes for 2.6.5
Message-ID: <20040414045443.GA12732@neo.rr.com>
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

This release includes various small bug fixes.  I've added P4P800 to the PnPBIOS
blacklist.  If anyone is having PnPBIOS problems with another board please let
me know.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.6

Thanks,
Adam

 arch/i386/kernel/dmi_scan.c    |    6 +++++-
 drivers/pnp/interface.c        |    2 +-
 drivers/pnp/isapnp/core.c      |    2 +-
 drivers/pnp/manager.c          |   24 ++++++++++--------------
 drivers/pnp/pnpbios/proc.c     |    2 +-
 drivers/pnp/pnpbios/rsparser.c |    5 +++++
 6 files changed, 23 insertions(+), 18 deletions(-)
-------

Adam Belay:
  o [PNPBIOS] avoid making potentially broken calls in proc.c
  o [PNPBIOS] blacklist asus P4P800
  o [PNP] sysfs entry "resource" fix
  o [PNP] minor resource management fixes
  o [PNPBIOS] parse asci text name

Jaroslav Kysela:
  o [ISAPNP] MEM32 fix in read resources
