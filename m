Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbRFVWKq>; Fri, 22 Jun 2001 18:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbRFVWKg>; Fri, 22 Jun 2001 18:10:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21006 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265542AbRFVWK3>; Fri, 22 Jun 2001 18:10:29 -0400
Subject: Re: For comment: draft BIOS use document for the kernel
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Fri, 22 Jun 2001 23:09:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), root@chaos.analogic.com,
        RSchilling@affiliatedhealth.org (Schilling Richard),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <200106221924.f5MJOcQ493255@saturn.cs.uml.edu> from "Albert D. Cahalan" at Jun 22, 2001 03:24:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DZ7R-0004FL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> lilo
> grub
> syslinux
> XFree86 (using virtual-8088 to run a video BIOS for a second card?)

Also for monitor identification

> dosemu?
> loadlin?

loadlin does. Dosemu can. It depends how it is configured

The Red Hat installer uses LRMI to do monitor identification by BIOS calls
too. I've not tried to document these users.

> the boot block that reads ext2 (in 1 kB -- damn what a hack)

The Linux8086 minixfs booter is an even better hack - its in C. 



