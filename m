Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUDGSOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbUDGSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:14:40 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:35510 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S264165AbUDGSNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:13:42 -0400
From: Jan Killius <jkillius@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm2
Date: Wed, 7 Apr 2004 20:13:37 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404072013.37483.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
There is a problem on x86-64 here is the error:
 CC      arch/x86_64/pci/../../i386/pci/irq.o
arch/i386/pci/irq.c: In function `pci_vector_resources':
arch/i386/pci/irq.c:1019: error: `SYSCALL_VECTOR' undeclared (first use in 
this function)
arch/i386/pci/irq.c:1019: error: (Each undeclared identifier is reported only 
once
arch/i386/pci/irq.c:1019: error: for each function it appears in.)
make[1]: *** [arch/x86_64/pci/../../i386/pci/irq.o] Error 1
make: *** [arch/x86_64/pci] Error 2

-- 
        Jan
