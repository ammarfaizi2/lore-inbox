Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAEKq7>; Fri, 5 Jan 2001 05:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAEKqk>; Fri, 5 Jan 2001 05:46:40 -0500
Received: from punt.aladdin.de ([194.123.19.6]:13177 "HELO punt.aladdin.de")
	by vger.kernel.org with SMTP id <S129383AbRAEKqe>;
	Fri, 5 Jan 2001 05:46:34 -0500
To: linux-kernel@vger.kernel.org
Cc: cpg@aladdin.de
Subject: compile error on 2.4.0
From: Christian Groessler <cpg@aladdin.de>
Date: 05 Jan 2001 11:46:12 +0100
Message-ID: <87vgruxonf.fsf@panther.aladdin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.0/include/linux/modversions.h   -c -o r128_cce.o r128_cce.c
r128_cce.c: In function `r128_cce_init_ring_buffer':
r128_cce.c:339: structure has no member named `agp'
r128_cce.c:333: warning: `ring_start' might be used uninitialized in this function
r128_cce.c: In function `r128_cce_packet':
r128_cce.c:1023: warning: unused variable `size'
r128_cce.c:1021: warning: unused variable `buffer'
r128_cce.c:1019: warning: unused variable `dev_priv'
make[3]: *** [r128_cce.o] Error 1


.config file on request...

regards,
chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
