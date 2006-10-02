Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWJBUMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWJBUMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWJBUML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:12:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49084 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964957AbWJBUMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:12:10 -0400
Subject: Re: [RFC PATCH] move drm to pci_request_irq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061002201229.GF3003@slug>
References: <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
	 <1159729523.2891.408.camel@laptopd505.fenrus.org>
	 <20061001193616.GF16272@parisc-linux.org>
	 <1159755141.2891.434.camel@laptopd505.fenrus.org>
	 <20061002200048.GC3003@slug>  <20061002201229.GF3003@slug>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 21:36:38 +0100
Message-Id: <1159821398.8907.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 20:12 +0000, ysgrifennodd Frederik Deweerdt:
> Hi,
> 
> This proof-of-concept patch converts the drm driver to use the
> pci_request_irq() function.

0 isn't invalid - it means no IRQ was assigned so wants a different
message.

