Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266769AbUGUXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266769AbUGUXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUGUXLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 19:11:25 -0400
Received: from vena.lwn.net ([206.168.112.25]:38326 "HELO lwn.net")
	by vger.kernel.org with SMTP id S266769AbUGUXLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 19:11:24 -0400
Message-ID: <20040721231123.13423.qmail@lwn.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: New dev model (was [PATCH] delete devfs)
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 21 Jul 2004 18:31:24 EDT."
             <40FEEEBC.7080104@quark.didntduck.org> 
Date: Wed, 21 Jul 2004 17:11:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, is there anywhere else that isn't subscriber-only that has the scoop?

For those who weren't here, the basic scoop is this:

- 2.6 is doing great, despite the fact that (by Andrew's reckoning) some
  10mb/month of patches are going into it.

- Linus is majorly pleased with how the partnership with Andrew has been
  working, and few people feel that he shouldn't be.  He is a little
  concerned about breaking a highly effective process when 2.7 forks.

- There is not a whole lot of pressure to create a 2.7 now, but a lot of
  interest in getting patches into the mainstream quickly.

The end result is that there may not be a 2.7 for a while.  Instead,
significant patches will continue to go into 2.6, after a vetting period
in -mm.  Andrew stated his willingness to consider, for example,
four-level page tables, MODULE_PARM removal, API changes, and more.  2.7
will only be created when it becomes clear that there are sufficient
patches which are truly disruptive enough to require it.  When 2.7 *is*
created, it could be highly experimental, and may turn out to be a
throwaway tree.

Andrew's vision, as expressed at the summit, is that the mainline kernel
will be the fastest and most feature-rich kernel around, but not,
necessarily, the most stable.  Final stabilization is to be done by
distributors (as happens now, really), but the distributors are expected
to merge their patches quickly.

Anybody disagree with that summary?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
