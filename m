Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTDHQO2 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTDHQO2 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:14:28 -0400
Received: from cruel.tal.org ([195.16.220.85]:2566 "EHLO fairytale.tal.org")
	by vger.kernel.org with ESMTP id S261876AbTDHQO0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:14:26 -0400
Message-ID: <00b101c2fdeb$e1aa6e20$56dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
Subject: Re: Linux 2.4.21-pre7
Date: Tue, 8 Apr 2003 19:28:18 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So here goes -pre7. Hopefully the last -pre.
>
Won't compile for my PPC:
---
        -o vmlinux
drivers/ide/idedriver.o(.text+0x1a544): In function `pmac_outbsync':
: undefined reference to `io_flush'
drivers/ide/idedriver.o(.text+0x1a544): In function `pmac_outbsync':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x118): In function
`pmac_ide_selectproc':
: undefined reference to `io_flush'
drivers/ide/idedriver.o(.text.pmac+0x118): In function
`pmac_ide_selectproc':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x1b4): In function
`pmac_ide_kauai_selectproc':
: undefined reference to `io_flush'
drivers/ide/idedriver.o(.text.pmac+0x1b4): In function
`pmac_ide_kauai_selectproc':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x2a4): In function
`pmac_ide_do_setfeature':
: undefined reference to `io_flush'
drivers/ide/idedriver.o(.text.pmac+0x2a4): In function
`pmac_ide_do_setfeature':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x1bcc): In function `pmac_ide_dma_read':
: undefined reference to `io_flush'
drivers/ide/idedriver.o(.text.pmac+0x1bcc): In function `pmac_ide_dma_read':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x1d48): more undefined references to
`io_flush' follow
drivers/ide/idedriver.o(.text.pmac+0x1d48): In function
`pmac_ide_dma_write':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x1e70): In function
`pmac_ide_dma_begin':
: relocation truncated to fit: R_PPC_REL24 io_flush
drivers/ide/idedriver.o(.text.pmac+0x2088): In function
`idepmac_sleep_device':
: relocation truncated to fit: R_PPC_REL24 io_flush
make: *** [vmlinux] Error 1

