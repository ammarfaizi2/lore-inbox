Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTDKTXA (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTDKTXA (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:23:00 -0400
Received: from freebsdcluster.dk ([195.184.98.178]:49933 "EHLO
	freebsdcluster.org") by vger.kernel.org with ESMTP id S261545AbTDKTW7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:22:59 -0400
Date: Fri, 11 Apr 2003 21:34:43 +0200
From: Vikram Rangnekar <vicky@freebsdcluster.net>
To: linux-kernel@vger.kernel.org
Subject: build breaks with UML patch
Message-ID: <20030411213443.A35199@freebsdcluster.dk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: FreeBSD freebsdcluster.dk 4.6-STABLE i386
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arch/i386/kernel/sys_i386.c: In function `do_mmap2':
arch/i386/kernel/sys_i386.c:59: warning: passing arg 1 of `do_mmap_pgoff'
from incompatible pointertype
arch/i386/kernel/sys_i386.c:59: warning: passing arg 2 of `do_mmap_pgoff'
makes pointer from integer without a cast
arch/i386/kernel/sys_i386.c:59: too few arguments to function `do_mmap_pgoff'
make[1]: *** [arch/i386/kernel/sys_i386.o] Error 1
make: *** [arch/i386/kernel] Error 2

When i try to make the 2.5.67 kernel with the uml-patch-2.5.67-1  

regards
Vikram (http://www.vicramresearch.com)
