Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbRAEC2W>; Thu, 4 Jan 2001 21:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRAEC2M>; Thu, 4 Jan 2001 21:28:12 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:36672 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129428AbRAEC16>; Thu, 4 Jan 2001 21:27:58 -0500
Date: Thu, 4 Jan 2001 21:29:51 -0500 (EST)
From: <stewart@neuron.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 module compile error (DRI for ATI Rage?)
Message-ID: <Pine.LNX.4.10.10101042109150.3010-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for
.modinfo
gcc -D__KERNEL__ -I/local/build/2.4.0/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/local/build/2.4.0/include/linux/modversions.h   -c -o r128_cce.o r128_cce.c
r128_cce.c: In function `r128_cce_init_ring_buffer':
r128_cce.c:339: structure has no member named `agp'
r128_cce.c:333: warning: `ring_start' might be used uninitialized in this
function
r128_cce.c: In function `r128_cce_packet':
r128_cce.c:1023: warning: unused variable `size'
r128_cce.c:1021: warning: unused variable `buffer'
r128_cce.c:1019: warning: unused variable `dev_priv'
{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for
.modinfo
make[3]: *** [r128_cce.o] Error 1
make[3]: Leaving directory `/local/build/2.4.0/drivers/char/drm'
make[2]: *** [_modsubdir_drm] Error 2
make[2]: Leaving directory `/local/build/2.4.0/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/local/build/2.4.0/drivers'
make: *** [_mod_drivers] Error 2


from a clean, unpatched 2.4.0 source base. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
