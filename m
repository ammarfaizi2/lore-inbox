Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTEZNDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTEZNDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:03:21 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:61708 "EHLO
	betawl.net") by vger.kernel.org with ESMTP id S264368AbTEZNDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:03:12 -0400
Date: Mon, 26 May 2003 15:16:19 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3
Message-ID: <20030526131618.GA3354@man.beta.es>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been around the 2.4.21 pre series for quite some time, I thought it
was known, but as it has not yet been fixed, I'm doubting it.

If you try to compile ide as modules you get unresolved symbols:

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-disk.o
depmod:         proc_ide_read_geometry
depmod:         ide_remove_proc_entries
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide-probe.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
depmod:         create_proc_ide_interfaces
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc3/kernel/drivers/ide/ide.o
depmod:         ide_release_dma
depmod:         ide_add_proc_entries
depmod:         pnpide_init
depmod:         ide_scan_pcibus
depmod:         proc_ide_read_capacity
depmod:         proc_ide_create
depmod:         ide_remove_proc_entries
depmod:         destroy_proc_ide_drives
depmod:         proc_ide_destroy
depmod:         create_proc_ide_interfaces

In case the compiler or anything else could affect this, I'm running gcc 3.3
in Debian sid.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
