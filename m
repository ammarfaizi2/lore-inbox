Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbUDRFPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUDRFPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:15:23 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:33541 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264128AbUDRFPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:15:18 -0400
Date: Sun, 18 Apr 2004 13:19:09 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Hugh Dickins <hugh@veritas.com>
Subject: [PATCH] update to the 2.6 autofs4 patchset
Message-ID: <Pine.LNX.4.58.0404181301540.3790@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.8, required 8,
	NO_REAL_NAME, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I have updated the autofs4 patchset inline with the discussion 
the other day regarding my changes to sys_chdir and sys_chroot.

I tested against 2.6.5-mm6.

The patches are, as usual at: 
http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/2.6.4

Changes:

- pushed the chdir and chroot handling to revalidate and
  removed redundant code. Hughs' patch is now not needed.
- Added code to set sub_version field in super block info
  struct that was omitted from original patches.

Basically, patch 5 has changed with 6 and 7 being redone to take account 
of line number changes.

Ian

