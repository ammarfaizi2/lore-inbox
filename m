Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbULFTXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbULFTXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbULFTXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:23:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:35809 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261619AbULFTXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:23:15 -0500
Subject: Re: Linux 2.6.10-rc3 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1102360851.2547.9.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 06 Dec 2004 11:20:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The compile regressions have been down for awhile.  Sorry about that.  I
fired them up again with a little newer compiler (3.4.1).  The list
below shows both Linus' and Andrew's releases since 2.6.9.  All the
regressions and detailed information are on the web site listed below.

John Cherry

----------------------------------------------------------------------


Linux 2.6 Compile Statistics (gcc 3.4.1)

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.9-rc2     13w/0e       0w/0e   774w/0e    6w/0e  15w/0e    857w/0e
2.6.9-rc2     14w/0e       0w/0e  1815w/11e  65w/0e  19w/0e   2157w/0e
(Compiles with gcc 3.2.2)
2.6.9-rc1      5w/0e       1w/0e  1069w/15e   6w/0e   4w/0e   1062w/1e
2.6.9          0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e


Linux 2.6 (mm tree) Compile Statistics (gcc 3.4.1)

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.10-rc2-mm4   15w/0e     1w/7e   421w/0e    6w/0e  16w/0e    408w/0e
2.6.10-rc2-mm3   15w/0e     0w/0e  1255w/12e  66w/0e  16w/0e   1507w/0e
2.6.10-rc2-mm2   15w/0e     0w/0e  1362w/15e  65w/0e  16w/0e   1612w/2e
2.6.10-rc2-mm1   15w/0e     0w/0e  1405w/11e  65w/0e  16w/0e   1652w/0e
2.6.10-rc1-mm5   16w/0e     0w/0e  1587w/0e   65w/0e  20w/0e   1834w/0e
2.6.10-rc1-mm4   16w/0e     0w/0e  1485w/9e   65w/0e  20w/0e   1732w/0e
(Compiles with gcc 3.2.2)
2.6.10-rc1-mm3    7w/31e    0w/9e   496w/141e  4w/0e   4w/50e   693w/83e
2.6.10-rc1-mm2   16w/1e     1w/1e   529w/1e    4w/0e  12w/1e    729w/0e
2.6.10-rc1-mm1   16w/1e     1w/1e   592w/1e    4w/0e  13w/1e    857w/0e
2.6.9-mm1         6w/1e     1w/1e  1761w/15e  65w/0e   9w/0e   2086w/0e
2.6.9-rc4-mm1     5w/0e     0w/0e  1766w/11e  43w/0e   6w/0e   1798w/0e
2.6.9-rc3-mm3     5w/0e     0w/0e  1756w/11e  43w/0e   4w/0e   1786w/0e
2.6.9-rc3-mm2    10w/0e     4w/9e  1754w/14e  43w/0e   4w/0e   1782w/1e
2.6.9-rc3-mm1    10w/0e     4w/10e 1768w/0e   43w/0e   4w/0e   1796w/0e
2.6.9-rc2-mm4    10w/0e     5w/0e  2573w/0e   41w/0e   4w/0e   2600w/0e
2.6.9-rc2-mm3    10w/0e     5w/0e  2400w/0e   41w/0e   4w/0e   2435w/0e
2.6.9-rc2-mm2    10w/0e     5w/0e  2919w/0e   41w/0e   4w/0e   2954w/0e
2.6.9-rc2-mm1     0w/0e     2w/0e  3541w/9e   41w/0e   3w/9e   3567w/0e
2.6.9-rc1-mm4     0w/0e     1w/0e    55w/0e    3w/0e   2w/0e     48w/0e
2.6.9-rc1-mm3     0w/0e     0w/0e    55w/13e   3w/0e   1w/0e     49w/1e
2.6.9-rc1-mm2     0w/0e     0w/0e    53w/11e   3w/0e   1w/0e     47w/0e
2.6.9-rc1-mm1     0w/0e     0w/0e    80w/0e    4w/0e   1w/0e     74w/0e


