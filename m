Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFUMJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFUMJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVFUMH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:07:56 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:60294 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261303AbVFUMHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:07:23 -0400
Date: Tue, 21 Jun 2005 13:07:12 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: git-pull-script on my linus tree fails..
Message-ID: <Pine.LNX.4.58.0506211304320.2915@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a git archive from just after 2.6.12-rc6, which I've not touched on
my local system..

Now I've just done

cd linux-2.6
git-pull-script rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

And I get:
sent 69638 bytes  received 17423079 bytes  52928.04 bytes/sec
total size is 135185594  speedup is 7.73
Updating from 27198d855abbfc82df69e81b6c8d2f333580114c to
1d345dac1f30af1cd9f3a1faa12f9f18f17f236e.
Destroying all noncommitted data!
Kill me within 3 seconds..
fatal: Entry 'Documentation/DocBook/scsidrivers.tmpl' would be overwritten
by merge. Cannot merge.

but I haven't touched that tree so I shouldn't get merge issues..

whatsup?

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

