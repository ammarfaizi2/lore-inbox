Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWFNXJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWFNXJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWFNXJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:09:06 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:15611 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964988AbWFNXJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:09:04 -0400
Date: Thu, 15 Jun 2006 01:08:50 +0200
From: Voluspa <lista1@comhem.se>
To: randy.dunlap@oracle.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Message-Id: <20060615010850.3d375fa9.lista1@comhem.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      drivers/acpi/glue.o
  CC      drivers/acpi/ec.o
drivers/acpi/ec.c: In function `acpi_ec_poll_read':
drivers/acpi/ec.c:341: error: union has no member named `polling'
drivers/acpi/ec.c:363: error: union has no member named `polling'
drivers/acpi/ec.c: In function `acpi_ec_poll_write':
drivers/acpi/ec.c:390: error: union has no member named `polling'
drivers/acpi/ec.c:415: error: union has no member named `polling'
drivers/acpi/ec.c:376: warning: unused variable `flags'
drivers/acpi/ec.c: In function `acpi_ec_poll_query':
drivers/acpi/ec.c:599: error: union has no member named `polling'
drivers/acpi/ec.c:615: error: union has no member named `polling'
drivers/acpi/ec.c:578: warning: unused variable `flags'
drivers/acpi/ec.c: In function `acpi_ec_gpe_poll_query':
drivers/acpi/ec.c:705: error: union has no member named `polling'
drivers/acpi/ec.c:708: error: union has no member named `polling'
drivers/acpi/ec.c:694: warning: unused variable `flags'
drivers/acpi/ec.c: In function `acpi_ec_poll_add':
drivers/acpi/ec.c:1020: error: union has no member named `polling'
drivers/acpi/ec.c: In function `acpi_fake_ecdt_poll_callback':
drivers/acpi/ec.c:1315: error: union has no member named `polling'
drivers/acpi/ec.c: In function `acpi_ec_poll_get_real_ecdt':
drivers/acpi/ec.c:1431: error: union has no member named `polling'
make[2]: *** [drivers/acpi/ec.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

Mvh
Mats Johannesson
--
