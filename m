Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbUCLSQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUCLSQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:16:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:37057 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S262377AbUCLSP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:15:56 -0500
Subject: Re: Linux 2.6.4 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403101924510.3693@ppc970.osdl.org>
References: <Pine.LNX.4.58.0403101924510.3693@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1079115208.5483.10.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 10:13:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics for 2.6.4 and 2.6.4-mm1 are now available.

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.4          1w/0e       0w/0e   145w/ 0e   7w/0e   3w/0e    142w/0e
2.6.4-rc2      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
2.6.4-rc1      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
2.6.3          1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
2.6.3-rc4      1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
2.6.3-rc3      1w/0e       0w/0e   145w/ 7e   9w/0e   3w/0e    148w/0e
2.6.3-rc2      1w/0e       0w/0e   141w/ 0e   9w/0e   3w/0e    144w/0e
2.6.3-rc1      1w/0e       0w/0e   145w/ 0e   9w/0e   3w/0e    177w/0e
2.6.2          1w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.2-rc3      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.2-rc2      0w/0e       0w/0e   153w/ 8e  12w/0e   3w/0e    188w/0e
2.6.2-rc1      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.1          0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
2.6.1-rc3      0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
2.6.1-rc2      0w/0e       0w/0e   166w/ 0e  12w/0e   3w/0e    205w/0e
2.6.1-rc1      0w/0e       0w/0e   167w/ 0e  12w/0e   3w/0e    206w/0e
2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e


Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.4-mm1         1w/0e     5w/0e   146w/ 5e   8w/0e   3w/0e    144w/0e
2.6.3-rc2-mm1     1w/0e     5w/0e   146w/12e  11w/0e   3w/0e    147w/2e
2.6.3-rc1-mm2     1w/0e     5w/0e   144w/ 0e  11w/0e   3w/0e    145w/0e
2.6.3-rc1-mm1     1w/0e     5w/0e   147w/ 5e  11w/0e   3w/0e    147w/0e
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
Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
Daily compiles (ia64): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running64.txt
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

John


