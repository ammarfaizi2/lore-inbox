Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTDRQOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTDRQOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:14:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263161AbTDRQNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:13:38 -0400
Date: Fri, 18 Apr 2003 09:24:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm4 devfs don't compile
Message-Id: <20030418092454.6b9aa705.rddunlap@osdl.org>
In-Reply-To: <20030418161732.GA14198@hh.idb.hist.no>
References: <20030418014536.79d16076.akpm@digeo.com>
	<20030418161732.GA14198@hh.idb.hist.no>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003 18:17:32 +0200 Helge Hafting <helgehaf@aitel.hist.no> wrote:

| I'd like to try mm4 and see how AS runs on scsi, but
| I got a compile error in devfs:
| 
|   gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall 
| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
| -mpreferred-stack-boundary=2 -march=pentium2 -Iinclude/asm-i386/mach-default 
| -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=base 
| -DKBUILD_MODNAME=devfs -c -o fs/devfs/base.o fs/devfs/base.c
| fs/devfs/base.c: In function `devfsd_notify':
| fs/devfs/base.c:1426: too many arguments to function `devfsd_notify_de'
| fs/devfs/base.c: In function `devfs_register':
| fs/devfs/base.c:1460: warning: too few arguments for format
| fs/devfs/base.c:1460: warning: too few arguments for format
| make[2]: *** [fs/devfs/base.o] Error 1
| make[1]: *** [fs/devfs] Error 2
| make: *** [fs] Error 2

Hi,

Please look at today's email archives.  I've seen at least 2 patches
posted to fix this.

--
~Randy
