Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTD3HnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 03:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTD3HnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 03:43:06 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:6016 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S262116AbTD3HnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 03:43:06 -0400
Date: Wed, 30 Apr 2003 10:56:50 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm3
In-Reply-To: <20030429235959.3064d579.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L0.0304301055510.4051-100000@webdev.ines.ro>
References: <20030429235959.3064d579.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  gcc -Wp,-MD,net/core/.netfilter.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=netfilter -DKBUILD_MODNAME=netfilter -c -o 
net/core/netfilter.o net/core/netfilter.c
net/core/netfilter.c: In function `nf_reinject':
net/core/netfilter.c:559: `i' undeclared (first use in this function)
net/core/netfilter.c:559: (Each undeclared identifier is reported only 
once
net/core/netfilter.c:559: for each function it appears in.)
net/core/netfilter.c:559: warning: left-hand operand of comma expression 
has no effect
net/core/netfilter.c:559: warning: left-hand operand of comma expression 
has no effect
make[2]: *** [net/core/netfilter.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2

