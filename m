Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUI2X6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUI2X6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUI2X6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:58:11 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:56781 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S269206AbUI2X6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:58:00 -0400
Message-ID: <415B4C07.9090401@verwilst.be>
Date: Thu, 30 Sep 2004 01:57:59 +0200
From: Bart Verwilst <bart@verwilst.be>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: nl, nl-be, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compilation error: 2.4.27
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Could anybody help me out with this problem: I'm having a compilation 
error.. Any ideas somebody?



Installed linux # make bzImage
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall 
-Wstrict-prototypes -Wno-
trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpref
erred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=main -c -o 
init/main.o in
it/main.c
In file included from /usr/src/linux-2.4.27/include/linux/config.h:4,
                 from init/main.c:14:
/usr/src/linux-2.4.27/include/linux/autoconf.h:687: parse error before 
')' token
In file included from /usr/src/linux-2.4.27/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.4.27/include/linux/slab.h:52: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:52: warning: type defaults to 
`int' in declaration of `kmem_find_general_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:52: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:53: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:54: parse error before 
"kmem_cache_t"
/usr/src/linux-2.4.27/include/linux/slab.h:54: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:55: parse error before 
"kmem_cache_t"
/usr/src/linux-2.4.27/include/linux/slab.h:55: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:55: warning: type defaults to 
`int' in declaration of `kmem_cache_create'
/usr/src/linux-2.4.27/include/linux/slab.h:55: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:56: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:56: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:57: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:57: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:58: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:58: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:59: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:59: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:60: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:60: warning: function 
declaration isn't a prototype
/usr/src/linux-2.4.27/include/linux/slab.h:68: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:68: warning: type defaults to 
`int' in declaration of `vm_area_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:68: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:69: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:69: warning: type defaults to 
`int' in declaration of `mm_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:69: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:70: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:70: warning: type defaults to 
`int' in declaration of `names_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:70: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:71: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:71: warning: type defaults to 
`int' in declaration of `files_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:71: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:72: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:72: warning: type defaults to 
`int' in declaration of `filp_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:72: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:73: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:73: warning: type defaults to 
`int' in declaration of `dquot_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:73: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:74: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:74: warning: type defaults to 
`int' in declaration of `bh_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:74: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:75: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:75: warning: type defaults to 
`int' in declaration of `fs_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:75: warning: data definition 
has no type or storage class
/usr/src/linux-2.4.27/include/linux/slab.h:76: parse error before '*' token
/usr/src/linux-2.4.27/include/linux/slab.h:76: warning: type defaults to 
`int' in declaration of `sigact_cachep'
/usr/src/linux-2.4.27/include/linux/slab.h:76: warning: data definition 
has no type or storage class
make: *** [init/main.o] Error 1



Thanks a lot in advance!

Kind regards,

Bart Verwilst
