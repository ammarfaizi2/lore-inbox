Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266455AbUA3FIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUA3FIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:08:21 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:48260 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266455AbUA3FIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:08:20 -0500
Date: Thu, 29 Jan 2004 23:53:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235304.GA12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

In reply to this message I will be posting PnP fixes against 2.6.2-rc2, and I would
appreciate if you would add them to your -mm tree.  If you choose to include them
in -mm, could you please remove the following patches first:

pnp-fix-2.patch
pnp-fix-3.patch
8250_pnp-cleanup.patch
alsa-pnp-fix.patch

Many of these patches have been updated since thier initial inclusion.  Just to be
safe, I think it would be best to start with a clean tree.  I apologize if I have
overlooked any other patches.

Also, I decided to drop the isapnp fix and will be looking into a more complete fix
shortly.  I'll have an update for it out soon.

This set of changes includes full support for the module_device_tables, various
fixes, and updated kconfig comments.

Thanks,
Adam
