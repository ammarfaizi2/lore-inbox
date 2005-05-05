Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVEETOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVEETOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVEETOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:14:33 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:48273 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262187AbVEES3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:16 -0400
Message-Id: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:31 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 00/21] CKRM: Core patch set with Classification Engine, basic controllers
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--

Here are the core patches for CKRM updated to 2.6.12-rc3, along with
the most basic classification engine and a slightly more advanced derivative
and, several bug fixes to the core code.

All of these changes have been tested on IA32 and PPC64, with CONIG_CKRM
on and off, including both basic functionality tests and a variety of
stress/performance tests.  There are still a few minor code cleanups that
are in progress, but nothing functional outstanding in this set.

Upcoming patches (soon to be included) are the memory controller (parts of
which are being currently discussed on linux-mm), the listen accept
queue and an IO contoller (or maybe two).

Here is the current series file:

01-diff_ckrm_events
02-diff_delay_acct
03-diff_ckrm_core
04-diff_rcfs
05-diff_taskclass
06-diff_sockclass
07-diff_numtasks
10-diff_docs
03a-missing_unlock
06a-ckrm_net_cb
06b-ckrm_sockc
07a-numtasks_config
07c-numtasks_cleanup
07c2-numtasks-undo-delete
09-01-rbce_fs
09-02-rbce_fs-main
09-03-rbce_main-opt
09-04-rbce_opt-core
09-05-rbce_core-crbce
ckrm-printf-cleanup
compiler-warning-fix

--
gerrit

