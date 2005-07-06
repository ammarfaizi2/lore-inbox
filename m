Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVGFTFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVGFTFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVGFTCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:02:37 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:49880 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262193AbVGFNuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:50:35 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200507061350.j66DoYXJ013167@clem.clem-digital.net>
Subject: 2.6.13-rc2 fails compile -- pci-driver.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Wed, 6 Jul 2005 09:50:34 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fyi:

  CC      drivers/pci/pci-driver.o
drivers/pci/pci-driver.c: In function `pci_match_device':
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:156: request for member `node' in something not a structure or union
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `__mptr'
drivers/pci/pci-driver.c:156: warning: initialization from incompatible pointer type
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:156: request for member `node' in something not a structure or union
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:156: request for member `node' in something not a structure or union
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `__mptr'
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:156: request for member `node' in something not a structure or union
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:157: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:159: dereferencing pointer to incomplete type
make[2]: *** [drivers/pci/pci-driver.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2

-- 
Pete Clements 
