Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130400AbRAOLpo>; Mon, 15 Jan 2001 06:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131159AbRAOLpe>; Mon, 15 Jan 2001 06:45:34 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:30423 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S130400AbRAOLpY>;
	Mon, 15 Jan 2001 06:45:24 -0500
Message-ID: <3A62E2F9.C6416A37@itwm.fhg.de>
Date: Mon, 15 Jan 2001 12:46:01 +0100
From: Martin Braun <braun@itwm.fhg.de>
Organization: Fraunhofer ITWM
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: braun@itwm.fhg.de
Subject: linux-2.4.1-pre3 CONFIG_HIGHMEM4G compile error
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I am trying to compile a new kernel with CONFIG_HIGMEM4G=y.
I get compile errors in linux/arch/i386/kernel/traps.c,
linux/mm/vmalloc.c and linux/fs/proc/kcore.c (PKMAP_BASE undeclared).
Is it sufficient to add #include <linux/highmem.h> ?

Cheers,

Martin Braun
-- 
+---------------------------------+----------------------------------+
| Martin Braun (Dipl.-Phys.)      | EMail: braun@itwm.fhg.de         |
| Fraunhofer Institut für Techno- |                                  |
| und Wirtschaftsmathematik       | Tel.: ++49(0)631/36681-19        |
| Gottlieb-Daimler-Straße         | Fax : ++49(0)631/36681-66        |
| D-67663 Kaiserslautern          | Geb.: PRE-Park 209               |
+---------------------------------+----------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
