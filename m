Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbTLaBt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbTLaBt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:49:56 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:41900 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S266090AbTLaBty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:49:54 -0500
Date: Tue, 30 Dec 2003 17:49:52 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200312310149.hBV1nqK28047@work.bitmover.com>
To: bitkeeper-users@work.bitmover.com, linux-kernel@vger.kernel.org
Subject: [BK] cset -x improvement (prototype)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of you use the cset -x feature in BK (which is a way of undoing
the effects of a particular changeset).

The documented behaviour of cset -x is that it only undoes content
changes, not renames, creates, permissions, etc.  This interface is
unique in that respect, all the other interfaces in BK operate on all
attributes, not just contents.

I've prototyped a version of the interface which works on contents,
names, and permissions, and in addition also uses the BK merge tools to
merge any conflicting changes as a result of the undo of the changeset.
This is JUST A PROTOTYPE and has a lot of limitations but I'd like some
feedback on whether this is a good direction and we should productize
this or if this is not helpful to you.

If you use cset -x and want a better version of that interface, drop me an
email and I'll send you the shell script (please make sure to send mail to
me directly, not to the lists, because (a) they don't need to see all the
noise and (b) I'm no longer subscribed to the Linux kernel mailing list).

Thanks,

--lm
