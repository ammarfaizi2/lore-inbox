Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSKSLZJ>; Tue, 19 Nov 2002 06:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSKSLZI>; Tue, 19 Nov 2002 06:25:08 -0500
Received: from big-relay-1.ftel.co.uk ([192.150.140.123]:57226 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S265230AbSKSLZF>; Tue, 19 Nov 2002 06:25:05 -0500
Date: Tue, 19 Nov 2002 11:32:04 +0000
From: Ian G Batten <I.G.Batten@ftel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 compilation problem
Message-ID: <20021119113204.GM3905@himalia.ftel.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Fujitsu Telecommunications Europe Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_IP_NF_TARGET_TCPMSS=m:

  gcc -Wp,-MD,net/ipv4/netfilter/.ipt_TCPMSS.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ipt_TCPMSS   -c -o net/ipv4/netfilter/ipt_TCPMSS.o net/ipv4/netfilter/ipt_TCPMSS.c
net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

ian
