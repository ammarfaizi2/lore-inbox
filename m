Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTDVTTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTDVTTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:19:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:58240 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263394AbTDVTTs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:19:48 -0400
Message-Id: <200304221931.h3MJVnLq004805@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 - clean up remaining '#if CONFIG*' (0/6)
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Apr 2003 15:31:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus - following are 6 patches against 2.5.68-bk3 to clean up the
remaining uses if '#if CONFIG*' in the source tree.  After these 6
patches, there are still remaining uses, but all are of the form
  #if CONFIG_VAR > VALUE
and it looks like the majority of them are "safe" in that the usage
is protected by some other #ifdef, and the corresponding Kconfig
assigns a default value.


-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech

