Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278521AbRJZOzX>; Fri, 26 Oct 2001 10:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278565AbRJZOzN>; Fri, 26 Oct 2001 10:55:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:42457 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S278522AbRJZOzA>;
	Fri, 26 Oct 2001 10:55:00 -0400
Date: Fri, 26 Oct 2001 16:55:31 +0200
From: Sebastian Heidl <heidl@zib.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: kbuild-2.5-2.4.11-pre5-1 on 2.4.13 -- failure
Message-ID: <20011026165531.R19509@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-www.distributed.net: 19 OGR packets (2.82 Tnodes) [4.25 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just wanted to give the new kbuild a try and got the following error
after doing 'make -f Makefile-2.5 menuconfig installable'

Rereading input trees to get new config timestamps
  phase 2 (evaluate selections)
pp_makefile2: Cannot find source for target fs/ext2/acl.o
make: *** [/usr/src/kernel/linux-2.4.13/.tmp_targets] Error 1
  

the patch succeeded on the plain 2.4.13 tree (two hunks had a slight offset).

any hints ?
_sh_

-- 
