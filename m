Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVLBULA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVLBULA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVLBULA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:11:00 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:22169 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751012AbVLBUK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:10:59 -0500
Subject: Followup on open/iscsi+core-iscsi
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: Open iSCSI <open-iscsi@googlegroups.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 12:05:50 -0800
Message-Id: <1133553950.26440.56.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All,

I just wanted to send a follow up note on the announcement that was made
yesterday relating to open/iscsi+core-iscsi project, and what it means
to users of iSCSI on Linux.  People looking for a stable, mature and
complete implementation of an iSCSI Initiator can deploy core-iscsi
v1.6.2.0 and core-iscsi-tools v3.0 on Linux 2.6 today.  Developers
interested in iSCSI should continue to focus their efforts on the
open/iscsi stack.  In the upcoming weeks, efforts will begin to start
porting over the core-iscsi-tools management interface and tools to
open/iscsi.  Keep in mind that core-iscsi-tools allows for many
different types of functionality that may or may not be currently
present and/or stable in open/iscsi.  So again, what this means today
is:

DEVELOPERS == Open/iSCSI
USERS == Core-iSCSI
THE FUTURE == Open/iSCSI+Core-iSCSI

The primary reason that active maintainence and development has been
resurrected on core-iscsi and core-iscsi-tools is to address the fact
that no iSCSI Initiator implementations existed that where practical for
the average user that where being actively maintained.  The average user
should not need to be concerned with the underlying iSCSI stack, but
only be concerned with the configuration and management side of the
core-iscsi project.  What this means for users of iSCSI on Linux today
is they can safely use core-iscsi on both the stack and tools side, and
know that when open/iscsi is ready to roll, there will be little, if no
breakage from their perspective during the migration process.

Additionally, a new update (v1.6.2.0-p1) containing a small fix to get
the core-iscsi stack to compile with GCC v4 (thanks to Lance Dillon on
this) has been put on kernel.org:

http://www.kernel.org/pub/linux/kernel/people/nab/iscsi-initiator-core/core-iscsi-v1.6.2.0-p1.tar.bz2

I would like to encourage people to give feedback on the Core-iSCSI
project's management layout, as well as any other comments.

Thanks!
  
-- 
Nicholas A. Bellinger <nab@kernel.org>

