Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWFFWT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWFFWT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFFWT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:19:28 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:29253 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751221AbWFFWT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:19:27 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc6 0/8] Kernel memory leak detector 0.6
Date: Tue, 06 Jun 2006 23:18:25 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060606221825.23913.43029.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.6) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the bundled patch or
the series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.17-rc6-kmemleak-0.6.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.6.tar.bz2

What's new in this version:

- fixed SMP locking (hopefully the last)
- added support for padded objects (allocated pointer different from
  the object one)
- fixed two false positives caused by padding

To do:

- more testing
- test Ingo's suggestion on task stacks scanning
- NUMA support
- (support for ioremap tracking)

-- 
Catalin
