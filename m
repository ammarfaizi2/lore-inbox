Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFTLwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFTLwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVFTLwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:52:16 -0400
Received: from office.icomedias.com ([62.99.232.80]:44198 "EHLO
	relay.icomedias.com") by vger.kernel.org with ESMTP id S261207AbVFTLwK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:52:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: AW: sata_promise KERNEL_BUG on 2.6.12
Date: Mon, 20 Jun 2005 13:52:03 +0200
Message-ID: <FA095C015271B64E99B197937712FD02510D59@freedom.grz.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sata_promise KERNEL_BUG on 2.6.12
Thread-Index: AcV1QeJIv/01ZJZQRTqytMK4mrPAXwARsqsA
From: "Martin Bene" <martin.bene@icomedias.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Marcel Naziri" <silent@zwobbl.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Marcel Naziri wrote:
> > Could the driver "remap" it? It's confusing that the boot 
> loader sees the 
> > drives in another way than the kernel do.
> 
> 
> Unfortunately it largely depends on how the board maker 
> decided to wire up the ports. If the Promise 
> driver gets it right, I probably need to 
> poke into BIOS somewhere...

Yes, I also saw that "reverse port numbering" effect on SATAII 150 TX4.

Bios + current Promise driver (for 2.4) agree on the port numbering,
matches the port# printed on the board.

Linux libsata driver uses reversed port numbering, otherwise works OK.

Bye, Martin
