Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUDZXG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUDZXG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDZXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:06:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:18118 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S262579AbUDZXGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:06:54 -0400
Subject: Re: 2.6.6-rc2-mm2 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040426013944.49a105a8.akpm@osdl.org>
References: <20040426013944.49a105a8.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083020809.10896.64.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Apr 2004 16:06:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the following warning (which results in some errors as well),
the function ignore_timer_override() should be behind the
CONFIG_ACPI_BOOT
define.

  CC      arch/i386/kernel/dmi_scan.o
arch/i386/kernel/dmi_scan.c:569: warning: `ignore_timer_override'
defined but
not used

-----------------------------------------------------------------------

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.6-rc1-mm2     0w/0e     1w/5e   118w/ 0e   8w/0e   3w/0e    118w/0e
2.6.6-rc1-mm1     0w/0e     0w/7e   122w/ 0e   7w/0e   4w/0e    122w/0e
2.6.5-mm6         0w/0e     0w/0e   123w/ 0e   7w/0e   4w/0e    124w/0e
2.6.5-mm5         0w/0e     0w/0e   119w/ 0e   7w/0e   4w/0e    120w/0e
2.6.5-mm4         0w/0e     0w/0e   120w/ 0e   7w/0e   4w/0e    121w/0e
2.6.5-mm3         0w/0e     1w/0e   121w/12e   7w/0e   3w/0e    123w/0e
2.6.5-mm2         0w/0e     0w/0e   128w/12e   7w/0e   3w/0e    134w/0e
2.6.5-mm1         0w/0e     5w/0e   122w/ 0e   7w/0e   3w/0e    124w/0e
2.6.5-rc3-mm4     0w/0e     0w/0e   124w/ 0e   8w/0e   4w/0e    126w/0e
2.6.5-rc3-mm3     0w/0e     5w/0e   129w/14e   8w/0e   4w/0e    129w/6e
2.6.5-rc3-mm2     0w/0e     5w/0e   130w/14e   8w/0e   4w/0e    129w/6e
2.6.5-rc3-mm1     0w/0e     5w/0e   129w/ 0e   8w/0e   4w/0e    129w/0e
2.6.5-rc2-mm5     0w/0e     5w/0e   130w/ 0e   8w/0e   4w/0e    129w/0e
2.6.5-rc2-mm4     0w/0e     5w/0e   134w/ 0e   8w/0e   3w/0e    133w/0e
2.6.5-rc2-mm3     0w/0e     5w/0e   134w/ 0e   8w/0e   3w/0e    133w/0e
2.6.5-rc2-mm2     0w/0e     5w/0e   137w/ 0e   8w/0e   3w/0e    134w/0e
2.6.5-rc2-mm1     0w/0e     5w/0e   136w/ 0e   8w/0e   3w/0e    134w/0e
2.6.5-rc1-mm2     0w/0e     5w/0e   135w/ 5e   8w/0e   3w/0e    133w/0e
2.6.5-rc1-mm1     0w/0e     5w/0e   135w/ 5e   8w/0e   3w/0e    133w/0e
2.6.4-mm2         1w/2e     5w/2e   144w/10e   8w/0e   3w/2e    144w/0e
2.6.4-mm1         1w/0e     5w/0e   146w/ 5e   8w/0e   3w/0e    144w/0e
2.6.4-rc2-mm1     1w/0e     5w/0e   146w/12e  11w/0e   3w/0e    147w/2e
2.6.4-rc1-mm2     1w/0e     5w/0e   144w/ 0e  11w/0e   3w/0e    145w/0e
2.6.4-rc1-mm1     1w/0e     5w/0e   147w/ 5e  11w/0e   3w/0e    147w/0e
2.6.3-mm4         1w/0e     5w/0e   146w/ 0e   7w/0e   3w/0e    142w/0e
2.6.3-mm3         1w/2e     5w/2e   146w/15e   7w/0e   3w/2e    144w/5e
2.6.3-mm2         1w/8e     5w/0e   140w/ 0e   7w/0e   3w/0e    138w/0e
2.6.3-mm1         1w/0e     5w/0e   143w/ 5e   7w/0e   3w/0e    141w/0e
2.6.3-rc3-mm1     1w/0e     0w/0e   144w/13e   7w/0e   3w/0e    142w/3e
2.6.3-rc2-mm1     1w/0e     0w/265e 144w/ 5e   7w/0e   3w/0e    145w/0e
2.6.3-rc1-mm1     1w/0e     0w/265e 141w/ 5e   7w/0e   3w/0e    143w/0e
2.6.2-mm1         2w/0e     0w/264e 147w/ 5e   7w/0e   3w/0e    173w/0e
2.6.2-rc3-mm1     2w/0e     0w/265e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc2-mm2     0w/0e     0w/264e 145w/ 5e   7w/0e   3w/0e    171w/0e
2.6.2-rc2-mm1     0w/0e     0w/264e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc1-mm3     0w/0e     0w/265e 144w/ 8e   7w/0e   3w/0e    169w/0e
2.6.2-rc1-mm2     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.2-rc1-mm1     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.1-mm5         2w/5e     0w/264e 153w/11e  10w/0e   3w/0e    180w/0e
2.6.1-mm4         0w/821e   0w/264e 154w/ 5e   8w/1e   5w/0e    179w/0e
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

John


