Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVAMXVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVAMXVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVAMXTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:19:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:49066 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261824AbVAMXPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:15:05 -0500
Subject: Re: Linux 2.6.11-rc1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 15:15:10 -0800
Message-Id: <1105658110.7296.61.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been awhile since I sent out compile stats for either Andrew's 
or Linus' releases.  Below are the stats for the last few releases
on both trees.  Full stats and data can be found as usual on:

http://developer.osdl.org/cherry/compile/

Linux 2.6 Compile Statistics (gcc 3.4.1)

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.11-rc1    20w/0e       0w/0e   497w/0e    6w/0e  22w/0e    577w/0e
2.6.10        13w/0e       0w/0e   778w/0e    6w/0e  15w/0e    861w/0e
2.6.9-rc3     13w/0e       0w/0e   774w/0e    6w/0e  15w/0e    857w/0e
2.6.9-rc2     14w/0e       0w/0e  1815w/11e  65w/0e  19w/0e   2157w/0e

Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt

Linux 2.6 (mm tree) Compile Statistics (gcc 3.4.1)
--------------------------------------------------

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.10-mm3       21w/0e     0w/0e   320w/0e    6w/0e  23w/0e    299w/0e
2.6.10-mm2       21w/0e     0w/0e   440w/0e    6w/0e  23w/0e    420w/0e
2.6.10-mm1       12w/0e     0w/0e   414w/0e    6w/0e  17w/0e    399w/0e
2.6.10-rc3-mm1   12w/0e     0w/0e   414w/0e    6w/0e  16w/0e    401w/0e
2.6.10-rc2-mm4   15w/0e     1w/7e   421w/0e    6w/0e  16w/0e    408w/0e
2.6.10-rc2-mm3   15w/0e     0w/0e  1255w/12e  66w/0e  16w/0e   1507w/0e
2.6.10-rc2-mm2   15w/0e     0w/0e  1362w/15e  65w/0e  16w/0e   1612w/2e
2.6.10-rc2-mm1   15w/0e     0w/0e  1405w/11e  65w/0e  16w/0e   1652w/0e
2.6.10-rc1-mm5   16w/0e     0w/0e  1587w/0e   65w/0e  20w/0e   1834w/0e
2.6.10-rc1-mm4   16w/0e     0w/0e  1485w/9e   65w/0e  20w/0e   1732w/0e

John



