Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271811AbRICUu0>; Mon, 3 Sep 2001 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271813AbRICUuQ>; Mon, 3 Sep 2001 16:50:16 -0400
Received: from c1765315-a.mckiny1.tx.home.com ([65.10.75.71]:260 "EHLO
	aruba.maner.org") by vger.kernel.org with ESMTP id <S271811AbRICUuG> convert rfc822-to-8bit;
	Mon, 3 Sep 2001 16:50:06 -0400
Subject: atomic_dec_and_lock again - sparc64 - 2.4.9-ac7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 3 Sep 2001 15:50:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
Message-ID: <C033B4C3E96AF74A89582654DEC664DBC969@aruba.maner.org>
Thread-Topic: atomic_dec_and_lock again - sparc64 - 2.4.9-ac7
Thread-Index: AcE0ug5gAVpHgg+VQji8C8vIvZPBXg==
From: "Donald Maner" <donjr@maner.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile 2.4.9-ac7, getting this...


sparc64-linux-gcc -D__KERNEL__ -I/home/donjr/linux-2.4.9-ac7/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7
-Wno-sign-compare -Wa,--undeclared-regs    -DEXPORT_SYMTAB -c
sparc64_ksyms.c
sparc64_ksyms.c:166: `atomic_dec_and_lock' undeclared here (not in a
function)
sparc64_ksyms.c:166: initializer element for
`__ksymtab_atomic_dec_and_lock.value' is not constant
make[1]: *** [sparc64_ksyms.o] Error 1
make[1]: Leaving directory
`/home/donjr/linux-2.4.9-ac7/arch/sparc64/kernel'
make: *** [_dir_arch/sparc64/kernel] Error 2

Any hints?
