Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVEPVED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVEPVED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEPVB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:01:27 -0400
Received: from dvhart.com ([64.146.134.43]:57505 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261884AbVEPVAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:00:15 -0400
Date: Mon, 16 May 2005 14:00:09 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc4-mm2 build failure
Message-ID: <734820000.1116277209@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64 box

drivers/ide/ide-probe.c: In function `ide_init_queue':
drivers/ide/ide-probe.c:982: warning: implicit declaration of function `pcibus_to_node'
drivers/ide/ide-disk.c: In function `ide_disk_probe':
drivers/ide/ide-disk.c:1225: warning: implicit declaration of function `pcibus_to_node'
drivers/built-in.o(.text+0xaee4c): In function `.init_irq':
: undefined reference to `.pcibus_to_node'
drivers/built-in.o(.text+0xaf01c): In function `.init_irq':
: undefined reference to `.pcibus_to_node'
drivers/built-in.o(.text+0xb7808): In function `.ide_disk_probe':
: undefined reference to `.pcibus_to_node'
make: *** [.tmp_vmlinux1] Error 1
05/16/05-07:36:03 Build the kernel. Failed rc = 2
05/16/05-07:36:03 build: kernel build Failed rc = 1


