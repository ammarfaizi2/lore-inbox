Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKHMfv>; Wed, 8 Nov 2000 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129690AbQKHMfl>; Wed, 8 Nov 2000 07:35:41 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:6149 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129245AbQKHMfc>; Wed, 8 Nov 2000 07:35:32 -0500
Message-Id: <200011081235.eA8CZ1i28208@pincoya.inf.utfsm.cl>
To: David Miller <davem@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.0.11.1: Typo en include/asm-sparc64/module.h
X-Mailer: MH [Version 6.8.4]
Date: Wed, 08 Nov 2000 09:35:01 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.0-test/include/asm-sparc64/module.h.dist-2.4.0-test11-pre1	Wed Nov  8 08:18:10 2000
+++ linux-2.4.0-test/include/asm-sparc64/module.h	Wed Nov  8 09:31:36 2000
@@ -6,6 +6,6 @@
 
 extern void * module_map (unsigned long size);
 extern void module_unmap (void *addr);
-#define module_arch_init (x)	(0)
+#define module_arch_init(x)	(0)
 
 #endif /* _ASM_SPARC64_MODULE_H */
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
