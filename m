Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSAXKCR>; Thu, 24 Jan 2002 05:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286756AbSAXKCK>; Thu, 24 Jan 2002 05:02:10 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:39327 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S286750AbSAXKB7>; Thu, 24 Jan 2002 05:01:59 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 24 Jan 2002 02:01:55 -0800
Message-Id: <200201241001.CAA00304@baldur.yggdrasil.com>
To: jes@trained-monkey.org, linux-acenic@sunsite.dk,
        linux-kernel@vger.kernel.org
Subject: linux-2.5.3-pre4/drivers/acenic.c: pci_unmap_addr_set not defined for x86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.3-pre4/drivers/acenic.c uses pci_unmap_addr_set,
which is defined for most architectures in include/asm-*/pci.h, but
not for i386.  For i386 this results in undefined references.  I
imagine that this is the result of a missed file (include/asm-i386/pci.h?)
from an Acenic update patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
