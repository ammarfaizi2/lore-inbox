Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVBXKN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVBXKN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVBXKLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:11:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:46225 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262138AbVBXJdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:47 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: [PATCH] CKRM [0/8] Long overdue response to initial review
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26633.1109237626.1@us.ibm.com>
Date: Thu, 24 Feb 2005 01:33:46 -0800
Message-Id: <E1D4FNS-0006vc-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long overdue response to the many code review comments
that came in during the last posting of the CKRM core code.   While
CKRM has not by any means been inactive, a variety of other deliverables
have taken precedence until recently.

However, the following set of postings is a step towards starting to
rectify that delinquincy, including a refresh to 2.6.11-rc5.  While
testing has been going over the past couple of weeks on a set of patches
very close to this, a large number of cleanups have happened in the past
couple of days and testing is not complete on those.  In particular,
I know of a couple of batches of warnings that need to be cleaned up
and I have a strong suspicion that building with at least one and maybe
two particular CKRM_* config options set to Y may fail to compile at
the moment.

Also, since the last submission, a couple of the patches have
been removed from the set that I'm including now.  One of them
needs a few updates and some air time on ckrm-tech because of some
slight networking related changes; the other was just too darn big
of a patch and is being broken into more reasonable sized pieces.

I was not able to make all changes requested by review comments thus
far; however, the ones that I did not get to have been added to
a TODO file in the Docuemntation directory for ckrm.

The following postings will contain the updated patches for
these components of CKRM:

The following patches include:

01-diff_ckrm_events:
	Base CKRM events, mods to existing kernel code

02-diff_delay_acct:
	More accurate accounting for CPU scheduling, IO scheduling

03-diff_ckrm_core:
	Main/core CKRM code, beginings of Resource Control Filesystem

04-diff_rcfs:
	Full directory suppport for rcfs

05-diff_taskclass:
	Task based management for CPU, memory and Disk I/O.

06-diff_sockclass:
	CKRM tracking for socket classes for inbound connection control,
	bandwidth control, etc.

07-diff_numtasks:
	Resource controller for number of tasks per class.

10-diff_docs
	CKRM documentation.

Please send comments to ckrm-tech@lists.sourceforge.net

thanks,

gerrit
