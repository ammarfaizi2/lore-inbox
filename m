Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTEWNRl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 09:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbTEWNRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 09:17:41 -0400
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:20453 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S264066AbTEWNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 09:17:39 -0400
Date: Fri, 23 May 2003 15:30:14 +0200 (CEST)
From: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: linux-kernel@vger.kernel.org, <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell Coker <russell@coker.com.au>
Subject: Re: Linux 2.4.21-rc3
In-Reply-To: <3ECE1DBF.5090602@gmx.net>
Message-ID: <Pine.LNX.4.44.0305231516470.29275-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Carl-Daniel Hailfinger wrote:

> Martijn Uffing wrote:
> > Ave
> > 
> > Modular ide is still broken in 2.4.21-rc3  with my config.
> 
> IIRC, Alan said it is not suposed to work yet. However, if you're
> feeling brave (and have no valuable data), you can try to export these
> symbols to make depmod happy. (Please read on)

I found "o fix modular ide build and other makefile bug" in Changelog so
 I thought to give it another try.



> 
> > "make modules_install" gives a:
> > 
> > depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-disk.o
> > depmod: 	proc_ide_read_geometry
> > depmod: 	ide_remove_proc_entries
> > depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-probe.o
> > depmod: 	do_ide_request
> > depmod: 	ide_add_generic_settings
> > depmod: 	create_proc_ide_interfaces
> > depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc3/kernel/drivers/ide/ide.o
> > depmod: 	ide_release_dma
> > depmod: 	ide_add_proc_entries
> > depmod: 	cmd640_vlb
> > depmod: 	ide_probe_for_cmd640x
> > depmod: 	ide_scan_pcibus
> > depmod: 	proc_ide_read_capacity
> > depmod: 	proc_ide_create
> > depmod: 	ide_remove_proc_entries
> > depmod: 	destroy_proc_ide_drives
> > depmod: 	proc_ide_destroy
> > depmod: 	create_proc_ide_interfaces
> > 
> > 
> no one can complain that the released kernel does not compile. Marcelo
> could just revert it for 2.4.22-pre then.
> 
> This is mainly to keep the complaint level down.
> 
> 
> Regards,
> Carl-Daniel
> 


Ehh 2.4.21-rc3 compiles fine with my config. It even runs fine! Only 
modular ide won't work. But if the changes are to invasive for 2.4.21 I 
can understand.

Greetz Mu





