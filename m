Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTEFJz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTEFJz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:55:57 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:24081 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262493AbTEFJz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:55:56 -0400
Date: Tue, 6 May 2003 12:08:12 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69 
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.51L.0305061205400.1232@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That kernel fails for me when building...
[cut]

gcc -Wp,-MD,fs/lockd/.clntproc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE -DKBUILD_BASENAME=clntproc -DKBUILD_MODNAME=lockd -c -o fs/lockd/.tmp_clntproc.o fs/lockd/clntproc.c
In file included from fs/lockd/clntproc.c:17:
include/linux/sunrpc/svc.h: In function `svc_take_page': 
include/linux/sunrpc/svc.h:180: invalid lvalue in assignment
make[3]: *** [fs/lockd/clntproc.o] Error 1
make[2]: *** [fs/lockd] Error 2
make[1]: *** [fs] Error 2
make: *** [modules] Error 2

My kernel config:
http://piorun.ds.pg.gda.pl/~blues/linux-2.5.69.txt

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
