Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268754AbRG0Bya>; Thu, 26 Jul 2001 21:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268755AbRG0ByU>; Thu, 26 Jul 2001 21:54:20 -0400
Received: from mail.mesatop.com ([208.164.122.9]:8459 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S268754AbRG0ByR>;
	Thu, 26 Jul 2001 21:54:17 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.8-pre1 build error in drivers/parport/parport_pc.c
Date: Thu, 26 Jul 2001 19:53:11 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072619531103.06728@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I got the following errors building 2.4.8-pre1.

Snippet from .config:

CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y

Steven

parport_pc.c:257: redefinition of `parport_pc_write_data'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:45: `parport_pc_write_data' previously defined here
parport_pc.c:262: redefinition of `parport_pc_read_data'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:53: `parport_pc_read_data' previously defined here
parport_pc.c:267: redefinition of `parport_pc_write_control'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:139: `parport_pc_write_control' previously defined here
parport_pc.c:284: redefinition of `parport_pc_read_control'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:156: `parport_pc_read_control' previously defined here
parport_pc.c:295: redefinition of `parport_pc_frob_control'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:168: `parport_pc_frob_control' previously defined here
parport_pc.c:320: redefinition of `parport_pc_read_status'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:193: `parport_pc_read_status' previously defined here
parport_pc.c:325: redefinition of `parport_pc_disable_irq'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:199: `parport_pc_disable_irq' previously defined here
parport_pc.c:330: redefinition of `parport_pc_enable_irq'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:204: `parport_pc_enable_irq' previously defined here
parport_pc.c:335: redefinition of `parport_pc_data_forward'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:133: `parport_pc_data_forward' previously defined here
parport_pc.c:340: redefinition of `parport_pc_data_reverse'
/usr/src/linux-2.4.8-pre1/include/linux/parport_pc.h:128: `parport_pc_data_reverse' previously defined here
make[3]: *** [parport_pc.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.8-pre1/drivers/parport'
