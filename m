Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTFMGuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTFMGuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:50:51 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:62963 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265178AbTFMGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:50:51 -0400
Date: Fri, 13 Jun 2003 00:04:09 -0700
From: Chris Wright <chris@wirex.com>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: [PATCH][LSM] Early init for security modules and various cleanups 0/4
Message-ID: <20030613000409.B31636@figure1.int.wirex.com>
Mail-Followup-To: torvalds@transmeta.com, akpm@digeo.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The subsequent patches are LSM updates relative to current bk.
The early init patch has been reviewed by arch maintainers, and nearly
all acked the first version.  This current version is a slight refinement
based on feedback from Sam Ravnborg, and was acked by at least DaveM.
I would be glad to split it apart however necessary to get it merged.
It's the last piece needed before the SELinux module can begin working
on merging.  The cleanups include removal of two unused hooks, and a bug
fix from Jakub Jelinek.  These patches have been tested on x86.  Please
let me know if there is any problem with merging these patches.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
