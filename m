Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUHEPpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUHEPpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUHEPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:45:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:17323 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267721AbUHEPpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:45:17 -0400
Subject: sparse warnings - going in the right direction
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091720581.8198.39.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 05 Aug 2004 08:43:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warnings are certainly going in the right direction.  The
sparse outputs for the last 2.6.8-rc* builds (allmodconfig builds)
can be viewed at...

http://developer.osdl.org/cherry/sparselog/sparselog.linux-2.6.8-rc1
http://developer.osdl.org/cherry/sparselog/sparselog.linux-2.6.8-rc2
http://developer.osdl.org/cherry/sparselog/sparselog.linux-2.6.8-rc3

Between rc1 and rc2:
  99 new warnings
  2181 fixed warnings
  details at http://developer.osdl.org/cherry/sparselog/diff.rc1_to_rc2

Between rc2 and rc3:
  20 new warnings
  2743 fixed warnings
  details at http://developer.osdl.org/cherry/sparselog/diff.rc2_to_rc3

Between rc1 and rc3 (summary of the previous diffs)
  43 new warnings
  4848 fixed warnings
  details at http://developer.osdl.org/cherry/sparselog/diff.rc1_to_rc3
  
At the risk of enhancing my reputation as "cron cherry", I'll go ahead 
and automate these builds (nightly on linus' tree) and inform the list
when there are any regressions in sparse and compiler warnings.  Stay 
tuned.

John



