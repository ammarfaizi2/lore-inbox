Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbUBWSyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUBWSyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:54:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:51946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261994AbUBWSyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:54:18 -0500
Subject: Re: 2.6.3-mm3 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1077562725.9079.7.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 23 Feb 2004 10:58:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The defconfig build is failing with 2.6.3-mm3...

In file included from scripts/sumversion.c:6:
scripts/modpost.h:12:23: elfconfig.h: No such file or directory

The allyesconfig build fails in sound/pci/mixart/mixart.c with...

In file included from sound/pci/mixart/mixart.c:33:
sound/pci/mixart/mixart.h:95: field `msg_taskq' has incomplete type
sound/pci/mixart/mixart.h:127: confused by earlier errors, bailing out

----------------------------------------------------------------------

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
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


