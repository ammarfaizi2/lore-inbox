Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129623AbRCHUSS>; Thu, 8 Mar 2001 15:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbRCHUSK>; Thu, 8 Mar 2001 15:18:10 -0500
Received: from bobas.nowytarg.top.pl ([212.244.190.69]:17417 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S129623AbRCHUR7>; Thu, 8 Mar 2001 15:17:59 -0500
Date: Thu, 8 Mar 2001 21:15:53 +0100
From: Daniel Podlejski <underley@underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: device3dfx compilation errors with 2.4.2-ac14
Message-ID: <20010308211553.A19975@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-GPG-Fingerprint: 299F 1820 582B 283A 5F50  37D9 AA0B 6E10 03D4 EA5D
X-Homepage: http://www.underley.eu.org/
X-Cert: http://www.brainbench.com/transcript.jsp?pid=124954
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/vmalloc.h:7,
                 from /usr/src/linux/include/asm/io.h:110,
                 from /usr/src/linux/include/asm/pci.h:26,
                 from /usr/src/linux/include/linux/pci.h:559,
                 from 3dfx_driver.c:125:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_fast':
/usr/src/linux/include/asm/pgalloc.h:47: `boot_cpu_data_R94da44ea' undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h:47: (Each undeclared identifier is reported only once
/usr/src/linux/include/asm/pgalloc.h:47: for each function it appears in.)
/usr/src/linux/include/asm/pgalloc.h: In function `free_pgd_fast':
/usr/src/linux/include/asm/pgalloc.h:58: `boot_cpu_data_R94da44ea' undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h: In function `get_pte_fast':
/usr/src/linux/include/asm/pgalloc.h:75: `boot_cpu_data_R94da44ea' undeclared (first use in this function)
/usr/src/linux/include/asm/pgalloc.h: In function `free_pte_fast':
/usr/src/linux/include/asm/pgalloc.h:85: `boot_cpu_data_R94da44ea' undeclared (first use in this function)
In file included from /usr/src/linux/include/asm/io.h:110,
                 from /usr/src/linux/include/asm/pci.h:26,
                 from /usr/src/linux/include/linux/pci.h:559,
                 from 3dfx_driver.c:125:
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc':
/usr/src/linux/include/linux/vmalloc.h:36: `boot_cpu_data_R94da44ea' undeclared (first use in this function)
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc_dma':
/usr/src/linux/include/linux/vmalloc.h:45: `boot_cpu_data_R94da44ea' undeclared (first use in this function)
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc_32':
/usr/src/linux/include/linux/vmalloc.h:54: `boot_cpu_data_R94da44ea' undeclared (first use in this function)

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... Whatever you do, I'll be two steps behind you
   Wherever you go, and I'll be there to remind you ...
