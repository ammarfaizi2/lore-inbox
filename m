Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUKSUS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUKSUS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKSUPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:15:08 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:20620 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261613AbUKSUOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:14:17 -0500
Date: Sat, 20 Nov 2004 09:15:26 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-ac10 compile error
Message-ID: <Pine.LNX.4.53.0411200859320.1593@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got compile error with 2.6.9-ac10

root@perfectpc:/home/linux-2.6.9# make bzImage modules>/dev/null
In file included from drivers/atm/../../include/asm/byteorder.h:5:
/usr/include/linux/compiler.h:1:2: warning: #warning "You shouldn't be using this header"
drivers/pnp/pnpbios/core.c: In function `pnpbios_init':
drivers/pnp/pnpbios/core.c:541: error: `acpi_disabled' undeclared (first use in this function)
drivers/pnp/pnpbios/core.c:541: error: (Each undeclared identifier is reported only once
drivers/pnp/pnpbios/core.c:541: error: for each function it appears in.)
make[3]: *** [drivers/pnp/pnpbios/core.o] Error 1
make[2]: *** [drivers/pnp/pnpbios] Error 2
make[1]: *** [drivers/pnp] Error 2
make: *** [drivers] Error 2

gcc version 3.4.2

Steve Kieu
