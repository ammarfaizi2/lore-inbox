Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270021AbRHQJwD>; Fri, 17 Aug 2001 05:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270025AbRHQJvn>; Fri, 17 Aug 2001 05:51:43 -0400
Received: from mx6.port.ru ([194.67.57.16]:13071 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S270021AbRHQJve>;
	Fri, 17 Aug 2001 05:51:34 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-irda - compilation failure
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.69]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15XgI6-0003rC-00@f12.port.ru>
Date: Fri, 17 Aug 2001 13:51:46 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-2.95.3

gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586    -c -o smc-ircc.o smc-ircc.c
smc-ircc.c: In function `smc_access':
smc-ircc.c:171: smc_access causes a section type conflict
smc-ircc.c: In function `smc_probe':
smc-ircc.c:183: smc_probe causes a section type conflict
smc-ircc.c: In function `smc_superio_fdc':
smc-ircc.c:343: smc_superio_fdc causes a section type conflict
smc-ircc.c: In function `smc_superio_lpc':
smc-ircc.c:357: smc_superio_lpc causes a section type conflict
smc-ircc.c: In function `ircc_init':
smc-ircc.c:379: ircc_init causes a section type conflict
smc-ircc.c: In function `ircc_open':
smc-ircc.c:420: ircc_open causes a section type conflict
make[4]: *** [smc-ircc.o] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.9/drivers/net/irda'



---


cheers,


   Samium Gromoff
