Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130861AbQLEPJb>; Tue, 5 Dec 2000 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbQLEPJW>; Tue, 5 Dec 2000 10:09:22 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:17963 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S130861AbQLEPJJ>; Tue, 5 Dec 2000 10:09:09 -0500
Message-ID: <3A2CFDEA.C2E61BE6@xmission.com>
Date: Tue, 05 Dec 2000 07:38:34 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lcalls ???
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would someone be so kind and inform where I might go ferret out why I'm
getting these multiple lcalls from pci-pc.o?

Would I look real hard at General Setup in make menuconfig??

The kernels I have maked all work, but this little area puzzles me....

_______________________________________________________________________
kgcc -D_KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -02
-fomit-frame-pointer -fno-strict-aliasing -pipe -march=i686  -c -o
pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input} 829: Warning: indirect lcall without `*'
{standard input}:911: Warning: indirect lcall without `*'
{standard input}:1006: Warning: indirect lcall without `*'
{standard input}:1046: Warning: indirect lcall without `*'
{standard input}:1076: Warning: indirect lcall without `*'
{standard input}:1106: Warning: indirect lcall without `*'
{standard input}:1137: Warning: indirect lcall without `*'
{standard input}:1166: Warning: indirect lcall without `*'
{standard input}:1195: Warning: indirect lcall without `*'
{standard input}:1497: Warning: indirect lcall without `*'
{standard input}:1592: Warning: indirect lcall without `*'
kgcc -D_KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -02
-fomit-frame-pointer -fno-strict-aliasing -pipe -march=i686  -c -o
pci-irq.o pci-irq.c
________________________________________________________________________

Any pointers here would be appreciated.

Thanks again,

Frank

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
