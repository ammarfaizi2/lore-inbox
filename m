Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRAEVJF>; Fri, 5 Jan 2001 16:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAEVIW>; Fri, 5 Jan 2001 16:08:22 -0500
Received: from pop3.web.de ([212.227.116.81]:55302 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S129267AbRAEVIC>;
	Fri, 5 Jan 2001 16:08:02 -0500
From: Gregor Essers <gregor.essers@web.de>
Date: Fri, 5 Jan 2001 22:07:21 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: bug of Nvidia (0.9.5) Drivers in 2.4 Kernel Enviroment
MIME-Version: 1.0
Message-Id: <01010522072100.03671@saintx.saintx.de>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the pre9 relaese to the final of the 2.4 Kernel i become this Errors, 
can someone help me or have someone an idea what this mean ??.

I will build this with the src.rpm from Nvidia with the spec file 

In file included from nv.c:52:
nv.h:131: warning: #warning This driver is not officially supported on 
post-2.2 
kernels
nv.c: In function `nv_lock_pages':
nv.c:556: warning: implicit declaration of function `mem_map_inc_count'
nv.c: In function `nv_unlock_pages':
nv.c:583: warning: implicit declaration of function `mem_map_dec_count'
nv.c: At top level:
nv.c:853: unknown field `unmap' specified in initializer
nv.c:853: warning: initialization from incompatible pointer type
make: *** [nv.o] Fehler 1
Bad exit status from /var/tmp/rpm-tmp.37085 (%build)



My System Config : 

AMD Durom 700
256MB of Ram 
15,2 IBM HDD
Geforce2 MX 32 MB Graphics-Card 
Epox ep8kta+ Mainboard




Thanks

Gregor Essers
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
