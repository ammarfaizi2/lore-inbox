Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278146AbRJRVK3>; Thu, 18 Oct 2001 17:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278149AbRJRVKT>; Thu, 18 Oct 2001 17:10:19 -0400
Received: from james.kalifornia.com ([208.179.59.2]:14437 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S278146AbRJRVKK>; Thu, 18 Oct 2001 17:10:10 -0400
Message-ID: <3BCF44C2.5030504@blue-labs.org>
Date: Thu, 18 Oct 2001 17:08:18 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011016
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [compile bug] 2.4.13-pre4 | i2o_pci.c:165 structure has no member named `pdev'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.13-pre4

make[3]: Entering directory `/usr/local/src/linux/drivers/message/i2o'
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i586    -DEXPORT_SYMTAB -c i2o_pci.c
i2o_pci.c: In function `i2o_pci_install':
i2o_pci.c:165: structure has no member named `pdev'

...
   c->bus.pci.irq = -1;
   c->bus.pci.queue_buggy = 0;
   c->bus.pci.dpt = 0;
   c->bus.pci.short_req = 0;
   c->bus.pci.pdev = dev;

Has someone already fixed this before I start digging?

David


