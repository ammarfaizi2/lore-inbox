Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVCDE0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVCDE0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCCV15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:27:57 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:27399 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262520AbVCCV1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:27:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=C3udovuXTdCH1X1KhC/zCgeFhyUDD1OcrxVhkjuoZXNGM+ElLPBwxYv7icKU9LX2fDpIhrAjYBcnGqEB3Zri0mdS60RZPNrZ22YHkgXqWhVOvZ7GKcDtDBc95aW4v9IGwMdhyaV9nBq8Sh8vGy338Y7OIbTXimOOloh6G15qg/0=
Message-ID: <dd02451d050303132662482b66@mail.gmail.com>
Date: Thu, 3 Mar 2005 22:26:37 +0100
From: Marko Rebrina <mrebrina@gmail.com>
Reply-To: Marko Rebrina <mrebrina@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with w6692 & kernel >=2.6.10
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problem with w6692 (mISDN-2005-02-25) & kernel >=2.6.10 (with
2.6.9 is OK!) 

# lspci
0000:01:07.0 Network controller: Winbond Electronics Corp W6692 (rev 01)

# modprobe w6692pci  protocol=2
FATAL: Error inserting w6692pci
(/lib/modules/2.6.11/kernel/drivers/isdn/hardware/mISDN/w6692pci.ko):
No such device

log:

CAPI Subsystem Rev 1.1.2.8
capi20: Rev 1.1.2.7: started up with major 68 (middleware+capifs)
Modular ISDN Stack core $Revision: 1.23 $
mISDNd: kernel daemon started
ISDN L1 driver version 1.11
ISDN L2 driver version 1.19
mISDN: DSS1 Rev. 1.26
Capi 2.0 driver file version 1.14
ISAC module $Revision: 1.16 $

Winbond W6692 PCI driver Rev. 1.12
ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 19 (level, high) -> IRQ 19
mISDN_w6692: found adapter Winbond W6692 at 0000:01:07.0
W6692: Winbond W6692 version (0): W6692 V00
kcapi: Controller 1: mISDN1 attached
mISDNd: test event done
w6692: IRQ 19 count 4
kcapi: card 1 "mISDN1" ready.
w6692 1 cards installed
try_ok(13) try_wait(0) try_mult(0) try_inirq(0)
irq_ok(4) irq_fail(0)
release_l1 id 1
release_udss1 refcnt 1 l3(f39faa40) inst(f39faab8)
kcapi: card 1 down.
kcapi: Controller 1: mISDN1 unregistered
