Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270060AbUJTMxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270060AbUJTMxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270315AbUJTMw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:52:26 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:1667 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S270343AbUJTMpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:45:44 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200410201245.i9KCjemA012862@clem.clem-digital.net>
Subject: 2.6.9-bk3 fails compile (serial/8250.c)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Wed, 20 Oct 2004 08:45:40 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fyi:

make -f scripts/Makefile.build obj=drivers/serial
make[2]: Entering directory `/sda3/usr/src/linux-2.6.9-bk3'
  gcc -Wp,-MD,drivers/serial/.8250.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer  -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686 -Iinclude/asm-i386/mach-default    -DKBUILD_BASENAME=8250 -DKBUILD_MODNAME=8250 -c -o drivers/serial/8250.o drivers/serial/8250.c
drivers/serial/8250.c:185: `UART_FCR_R_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:185: initializer element is not constant
drivers/serial/8250.c:185: (near initialization for `uart_config[4].fcr')
drivers/serial/8250.c:203: `UART_FCR_R_TRIG_01' undeclared here (not in a function)
drivers/serial/8250.c:204: `UART_FCR_T_TRIG_00' undeclared here (not in a function)
drivers/serial/8250.c:204: initializer element is not constant
drivers/serial/8250.c:204: (near initialization for `uart_config[7].fcr')
drivers/serial/8250.c:211: `UART_FCR_R_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:212: initializer element is not constant
drivers/serial/8250.c:212: (near initialization for `uart_config[8].fcr')
drivers/serial/8250.c:224: `UART_FCR_R_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:224: initializer element is not constant
drivers/serial/8250.c:224: (near initialization for `uart_config[10].fcr')
drivers/serial/8250.c:231: `UART_FCR_R_TRIG_01' undeclared here (not in a function)
drivers/serial/8250.c:232: `UART_FCR_T_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:232: initializer element is not constant
drivers/serial/8250.c:232: (near initialization for `uart_config[11].fcr')
drivers/serial/8250.c:239: `UART_FCR_R_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:239: initializer element is not constant
drivers/serial/8250.c:239: (near initialization for `uart_config[12].fcr')
drivers/serial/8250.c:246: `UART_FCR_R_TRIG_11' undeclared here (not in a function)
drivers/serial/8250.c:246: initializer element is not constant
drivers/serial/8250.c:246: (near initialization for `uart_config[13].fcr')
drivers/serial/8250.c:253: `UART_FCR_R_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:253: initializer element is not constant
drivers/serial/8250.c:253: (near initialization for `uart_config[14].fcr')
drivers/serial/8250.c:260: `UART_FCR_R_TRIG_10' undeclared here (not in a function)
drivers/serial/8250.c:260: initializer element is not constant
drivers/serial/8250.c:260: (near initialization for `uart_config[15].fcr')
make[2]: *** [drivers/serial/8250.o] Error 1
make[2]: Leaving directory `/sda3/usr/src/linux-2.6.9-bk3'


-- 
Pete Clements 
