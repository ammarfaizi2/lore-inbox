Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVJLRIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVJLRIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVJLRIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:08:49 -0400
Received: from fmr23.intel.com ([143.183.121.15]:31887 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964802AbVJLRIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:08:48 -0400
Message-Id: <200510121708.j9CH8lg25344@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel performance update - 2.6.14-rc4
Date: Wed, 12 Oct 2005 10:08:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXPT46nO6hVzC3dS2Gkylae/OH8sQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel performance data for 2.6.14-rc4 is updated at:
http://kernel-perf.sourceforge.net

991 patches went in for rc4 since rc3, all perf. results are
pretty much flat compares to 2.6.14-rc3.  This is probably as
expected since kernel is in the quiet mode.

Result with fileio went up on IPF box, and it is because of a
intermittent bug in the mpt fusion scsi driver. A fix is
proposed [*] and we have verified that the patch improved
regression seen with fileio.

We are working on having a sensible configuration for dbench,
all numbers for dbench presented on the web site are taken with
default parameters, and it needs to be taken with a grain of
salt at the moment.

	Ken Chen
	Intel Opensource Technology Center


[*] mpt fusion driver performance issue in 2.6.14-rc2
http://marc.theaimsgroup.com/?t=112802043200007&r=1&w=2

