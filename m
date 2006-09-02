Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWIBJGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWIBJGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 05:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWIBJGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 05:06:03 -0400
Received: from lns-bzn-50f-81-56-194-193.adsl.proxad.net ([81.56.194.193]:31141
	"EHLO philou.philou.org") by vger.kernel.org with ESMTP
	id S1750855AbWIBJGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 05:06:01 -0400
Date: Sat, 2 Sep 2006 11:05:51 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= <philippe@gramoulle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.4.0cvs79 (GTK+ 2.8.18; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060902090552.AF91434AC@philou.gramoulle.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew,

On Fri, 1 Sep 2006 01:58:18 -0700
Andrew Morton <akpm@osdl.org> wrote:

  | ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/

2.6.18-rc5-mm1 doesn't build whereas 2.6.18-rc5 does.

p4:/usr/src/linux-2.6.17# make bzImage
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC      arch/i386/kernel/sys_i386.o
arch/i386/kernel/sys_i386.c: In function 'kernel_execve':
arch/i386/kernel/sys_i386.c:262: error: '__NR_execve' undeclared (first use in this function)
arch/i386/kernel/sys_i386.c:262: error: (Each undeclared identifier is reported only once
arch/i386/kernel/sys_i386.c:262: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/sys_i386.o] Error 1
make: *** [arch/i386/kernel] Error 2


P4 x86

Thanks,

Philippe

-- 
VGER BF report: H 1.56412e-06
