Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLMTmv>; Wed, 13 Dec 2000 14:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129437AbQLMTmm>; Wed, 13 Dec 2000 14:42:42 -0500
Received: from sulaco.cac.washington.edu ([128.95.135.10]:29112 "EHLO
	sulaco.cac.washington.edu") by vger.kernel.org with ESMTP
	id <S129257AbQLMTmX>; Wed, 13 Dec 2000 14:42:23 -0500
Date: Wed, 13 Dec 2000 11:11:56 -0800 (PST)
From: Tracy Stenvik <imf@u.washington.edu>
X-X-Sender: <imf@sulaco.cac.washington.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test12 unresolved symbols in ide-scsi.o
In-Reply-To: <Pine.LNX.4.30.0012131847020.20893-100000@melkki.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.31.0012131108010.13631-100000@sulaco.cac.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's not just limited to ide-scsi...

# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/scsi/aic7xxx.o
depmod:         scsi_command_size
depmod:         scsi_unregister_module
depmod:         scsi_register
depmod:         scsi_register_module
depmod:         scsi_partsize
depmod:         scsi_unregister
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o
depmod:         scsi_unregister_module
depmod:         scsi_register
depmod:         scsi_register_module
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/scsi/sg.o
depmod:         scsi_ioctl_send_command
depmod:         scsi_command_size
depmod:         scsi_dma_free_sectors
depmod:         scsi_unregister_module
depmod:         scsi_block_when_processing_errors
depmod:         scsi_release_request
depmod:         scsi_do_req
depmod:         scsi_allocate_request
depmod:         proc_scsi
depmod:         print_req_sense
depmod:         scsi_register_module
depmod:         scsi_ioctl
depmod:         scsi_hostlist
depmod:         scsi_sleep
depmod:         scsi_free
depmod:         scsi_malloc
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/scsi/sr_mod.o
depmod:         scsi_io_completion
depmod:         scsi_wait_req
depmod:         scsi_unregister_module
depmod:         scsi_block_when_processing_errors
depmod:         scsi_release_request
depmod:         scsi_allocate_request
depmod:         print_req_sense
depmod:         scsi_register_module
depmod:         print_command
depmod:         scsi_ioctl
depmod:         scsi_sleep
depmod:         scsi_free
depmod:         scsi_malloc
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/scsi/st.o
depmod:         scsi_unregister_module
depmod:         scsi_block_when_processing_errors
depmod:         scsi_release_request
depmod:         scsi_do_req
depmod:         scsi_allocate_request
depmod:         print_req_sense
depmod:         scsi_register_module
depmod:         scsi_ioctl
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/scsi/sym53c8xx.o
depmod:         scsi_unregister_module
depmod:         scsicam_bios_param
depmod:         scsi_register
depmod:         scsi_register_module
depmod:         scsi_unregister
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test12/kernel/drivers/usb/storage/usb-storage.o
depmod:         scsi_unregister_module
depmod:         scsi_register
depmod:         scsi_register_module

---
Tracy Stenvik
University Computing Services 354843.  University of Washington
email: imf@u.washington.edu  voice: (206) 685-3344

On Wed, 13 Dec 2000, Samuli Kaski wrote:

> I didn't change my config and things work with test11. Sorry for the
> noise if I have missed some announcement about ide-scsi.
>
> /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: unresolved symbol scsi_unregister_module
> /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: unresolved symbol scsi_register
> /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: unresolved symbol scsi_register_module
> /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: insmod /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o failed
> /lib/modules/2.4.0-test12/kernel/drivers/scsi/ide-scsi.o: insmod ide-scsi failed
>
> 	Samuli
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
