Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318975AbSHWRkO>; Fri, 23 Aug 2002 13:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318984AbSHWRkO>; Fri, 23 Aug 2002 13:40:14 -0400
Received: from host.greatconnect.com ([209.239.40.135]:5394 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S318975AbSHWRkN>; Fri, 23 Aug 2002 13:40:13 -0400
Subject: Re: 2.4.20-pre4-ac1 modular IDE symbol problems
From: Samuel Flory <sflory@rackable.com>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208231528560.2524-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208231528560.2524-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Aug 2002 10:43:29 -0700
Message-Id: <1030124610.23141.1294.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This is a know issue in Alan's release notes.


On Fri, 2002-08-23 at 07:30, Matt Bernstein wrote:
> Hope the below is useful (I know not too many people build IDE as modules)
> (built using Red Hat (null))
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-disk.o
> depmod:         proc_ide_read_geometry
> depmod:         ide_remove_proc_entries
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-floppy.o
> depmod:         proc_ide_read_geometry
> depmod:         ide_remove_proc_entries
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-probe.o
> depmod:         do_ide_request
> depmod:         ide_add_generic_settings
> depmod:         create_proc_ide_interfaces
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide-tape.o
> depmod:         ide_remove_proc_entries
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre4-ac1/kernel/drivers/ide/ide.o
> depmod:         ide_release_dma
> depmod:         ide_add_proc_entries
> depmod:         ide_scan_pcibus
> depmod:         proc_ide_read_capacity
> depmod:         proc_ide_create
> depmod:         ide_remove_proc_entries
> depmod:         destroy_proc_ide_drives
> depmod:         proc_ide_destroy
> depmod:         create_proc_ide_interfaces
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


