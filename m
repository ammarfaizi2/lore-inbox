Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265536AbRFVVue>; Fri, 22 Jun 2001 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265538AbRFVVub>; Fri, 22 Jun 2001 17:50:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5134 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265536AbRFVVuK>; Fri, 22 Jun 2001 17:50:10 -0400
Subject: Re: For comment: draft BIOS use document for the kernel
To: root@chaos.analogic.com
Date: Fri, 22 Jun 2001 22:42:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        RSchilling@affiliatedhealth.org (Schilling Richard),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <Pine.LNX.3.95.1010622135228.3929C-100000@chaos.analogic.com> from "Richard B. Johnson" at Jun 22, 2001 02:01:00 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DYhb-0004Ba-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then how does 1.44 megabytes of data from a floppy disk (that won't
> fit below 1 megabyte), that is accessed in real-mode, ever get to
> above 1 megabyte where it can be decompressed?

The limit is about 508K of compressed image with the floppy boot.

> I think LILO copies each buffer read from a below 1 Megabyte buffer
> (which is the only place the floppy can put its data via the BIOS),
> to above 1 megabyte using the BIOS block-move function.

I can't speak for LILO. I've not tried to document LILO, rather I've tried
to document the kernel. Possibly someone should add LILO documentation to
this.

Alan

