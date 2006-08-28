Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWH1Lei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWH1Lei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWH1Lei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:34:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36227 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964829AbWH1Lei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:34:38 -0400
Subject: Re: linux on Intel D915GOM oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Henti Smith <henti@geekware.co.za>, linux-kernel@vger.kernel.org
In-Reply-To: <1156754346.3034.167.camel@laptopd505.fenrus.org>
References: <20060828102149.26b05e8b@yoda.foad.za.net>
	 <1156754346.3034.167.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Aug 2006 12:56:05 +0100
Message-Id: <1156766165.6271.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 10:39 +0200, ysgrifennodd Arjan van de Ven:
> > [<c01f5724>] bios32_service+0x1c/0x68
> > [<c01f5780>] check_pcibios+0x10/0xd3
> > [<c01f5a77>] pci_find_bios+0x70/0x8c
> 
> this is the known bug where by default Linux uses the BIOS services for
> PCI rather than the native method.

No that trace is a bug in the BIOS. Ask the vendor [politely] for a BIOS
update, and if you can find a good technical contact the trace may help
them

> try putting
> 
> pci=conf2

conf2 or conf1 ??

Alan

