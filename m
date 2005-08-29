Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVH2X6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVH2X6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVH2X6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:58:01 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:55711 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S932089AbVH2X6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:58:01 -0400
Date: Mon, 29 Aug 2005 16:58:09 -0700
From: Jim McCloskey <mcclosk@ucsc.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.13, Inconsistent kallsyms data
Message-ID: <20050829235809.GA19979@branci40>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux/2.6.11.3 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to compile 2.6.13, using a complete tarball from
kernel.org, the compilation fails with:

-----------------------------------------------------------
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
Inconsistent kallsyms data
Try setting CONFIG_KALLSYMS_EXTRA_PASS
make: *** [vmlinux] Error 1
-----------------------------------------------------------

When CONFIG_KALLSYMS_EXTRA_PASS is set, the compilation completes
successfully.

I'm reporting the problem as requested in the configuration help
files.

I see that this problem has a history, but I'm not sure what
information I can supply that would be useful. If I can help in any
way, please let me know how. My technical skills are limited.

Jim McCloskey

