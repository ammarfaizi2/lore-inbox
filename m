Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131913AbQLZSDQ>; Tue, 26 Dec 2000 13:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131915AbQLZSDF>; Tue, 26 Dec 2000 13:03:05 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:49156 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131913AbQLZSC4>; Tue, 26 Dec 2000 13:02:56 -0500
Message-Id: <200012261726.eBQHQ7D02272@pincoya.inf.utfsm.cl>
To: Alan.Cox@linux.org, "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.2.19pre3 on sparc64: Undefined symbols in fs/binfmt_elf module
X-Mailer: MH [Version 6.8.4]
Date: Tue, 26 Dec 2000 14:26:07 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ultra 1, Red Hat 6.2 + updates and binutils-2.10.0.33, modutils-2.3.22-1.
Mostly modular kernel.

depmod: *** Unresolved symbols in /lib/modules/2.2.19pre3/fs/binfmt_elf.o
depmod: 	get_pte_slow
depmod: 	get_pmd_slow
depmod: 	pgt_quicklists

These seem to be sparc64-specific (defined in arch/sparc64/mm/init.c), and
so probably should go into arch/sparc64/kernel/sparc64_ksyms.c
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
