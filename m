Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTE0Iep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTE0Iep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:34:45 -0400
Received: from [195.95.38.160] ([195.95.38.160]:3834 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262776AbTE0Ieo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:34:44 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.70 compile error
Date: Tue, 27 May 2003 10:48:29 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305271048.36495.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 27 May 2003 04:08, Linus Torvalds wrote:
  CC      arch/i386/kernel/numaq.o
In file included from arch/i386/kernel/numaq.c:31:
include/asm/numaq.h:31:1: warning: "MAX_NUMNODES" redefined
In file included from include/linux/gfp.h:4,
                 from include/linux/slab.h:14,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:30,
                 from include/linux/mm.h:4,
                 from arch/i386/kernel/numaq.c:27:
include/linux/mmzone.h:18:1: warning: this is the location of the previous 
definition
arch/i386/kernel/numaq.c: In function `initialize_physnode_map':
arch/i386/kernel/numaq.c:95: error: `physnode_map' undeclared (first use in 
this  function)
arch/i386/kernel/numaq.c:95: error: (Each undeclared identifier is reported 
only  once
arch/i386/kernel/numaq.c:95: error: for each function it appears in.)
make[2]: *** [arch/i386/kernel/numaq.o] Error 1
make[1]: *** [arch/i386/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.70'
make: *** [stamp-build] Error 2

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+0yZgpuyeqyCEh60RAtKyAKCAdKBfpSpVvbAbcJn0rW8Mi/8/SgCeKQra
H68W1INRt+vtCwKcAEs6rvU=
=XkHu
-----END PGP SIGNATURE-----

