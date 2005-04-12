Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVDLCbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVDLCbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 22:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVDLCbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 22:31:21 -0400
Received: from mx2.netapp.com ([216.240.18.37]:17229 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S262004AbVDLCbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 22:31:00 -0400
X-IronPort-AV: i="3.92,95,1112598000"; 
   d="scan'208"; a="192839654:sNHT23254916"
Message-ID: <425B32E2.9010404@lists.sourceforge.net>
Date: Mon, 11 Apr 2005 22:30:58 -0400
From: linux-iscsi development team 
	<linux-iscsi-devel@lists.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-iscsi-devel@lists.sourceforge.net,
       linux-iscsi-users@lists.sourceforge.net, open-iscsi@googlegroups.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, iscsitarget-devel@lists.sourceforge.net
CC: itn780@yahoo.com, dmitry_yus@yahoo.com, mikenc@us.ibm.com,
       cnitin@cisco.com, smithan@cisco.com, coughlan@redhat.com,
       alewis@redhat.com, mbasavai@cisco.com, andmike@us.ibm.com,
       Ming Zhang <mingz@ele.uri.edu>
Subject: [ANNOUNCE] open-iscsi and linux-iscsi project teams have merged!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-iscsi and open-iscsi developers would like to announce
that they have combined forces on a single iSCSI initiator effort!

This mail gives an overview of this combined effort and will be followed
by a set of iSCSI patches the combined team submits for review as a
candidate for inclusion into the mainline kernel.

Background

After some dialog with the developers on each team, it was decided
that although each team started out with independent code and some
differences in architecture, it was worth considering the possibility
of combining the two efforts into one.  Alternatives were considered
for the combined architecture of the two projects, including adding
an option for a kernel control plane.  After discussions, it was
decided by consensus that the open-iscsi architecture and code would
be the best starting point for the "next gen" linux-iscsi project.
The advantages of this starting point include open-iscsi's optimized
I/O paths that were built from scratch, as well as incorporation of
well tested iscsi-sfnet components for the control plane and userspace
components.  The combined open-iscsi and linux-iscsi teams believe
this will result in the highest performing and most stable iSCSI stack
for Linux.

Overview of Combined Project

This new combined effort will consist of the open-iscsi code and
developers moving over to the linux-iscsi project on sourceforge
(http://sourceforge.net/projects/linux-iscsi/).  The open-iscsi
(http://www.open-iscsi.org) architecture will be the basis for
the "next gen" of linux-iscsi, which will be numbered the
linux-iscsi-5.x release series.

Release Numbering

If you were following the open-iscsi series, here is the mapping
between the open-iscsi numbering and the linux-iscsi-5.x numbering:
- open-iscsi-0.2 == linux-iscsi-5.0.0.2

Kernel Submission

The kernel component of the first release in this linux-iscsi 5.x
series will follow shortly, and the combined teams wish to submit
this as a candidate for inclusion into the mainline kernel.
If you've reviewed the previous open-iscsi patch set, you'll find
that this patchset is very similar, with previous reviewer comments
incorporated.

Thanks.

- The combined open-iscsi and linux-iscsi teams


