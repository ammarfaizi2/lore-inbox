Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135761AbRDZRb5>; Thu, 26 Apr 2001 13:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135766AbRDZRbs>; Thu, 26 Apr 2001 13:31:48 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:43022 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S135761AbRDZRbj>; Thu, 26 Apr 2001 13:31:39 -0400
Date: Thu, 26 Apr 2001 19:28:58 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [2.4.3-ac14] build failure
Message-ID: <20010426192858.A18680@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 2.95.2, gnu ld 2.9.5, x86 fails build:

make[3]: Entering directory `/usr/src/linux-2.4.3-ac14/drivers/net'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-ac14/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i586    -c -o pcnet32.o pcnet32.c
pcnet32.c:1385: warning: #warning "PCI posting bug"
pcnet32.c:327: pcnet32_pci_tbl causes a section type conflict
make[3]: *** [pcnet32.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.3-ac14/drivers/net'

-- 
Matthias Andree
