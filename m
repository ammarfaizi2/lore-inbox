Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSDOT7m>; Mon, 15 Apr 2002 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313196AbSDOT7m>; Mon, 15 Apr 2002 15:59:42 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16901
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313194AbSDOT7k>; Mon, 15 Apr 2002 15:59:40 -0400
Date: Mon, 15 Apr 2002 12:59:20 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Josh McKinney <forming@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
In-Reply-To: <20020415190946.GA1383@cy599856-a>
Message-ID: <Pine.LNX.4.10.10204151258400.1699-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3a.patch.bz2

Lets try it again, I diffed the wrong tree :-/

On Mon, 15 Apr 2002, Josh McKinney wrote:

> On approximately Mon, Apr 15, 2002 at 11:39:14AM -0700, Andre Hedrick wrote:
> > 
> > http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3a.patch.bz2
> > 
> Just got this when compiling...
> 
> drivers/ide/idedriver.o: In function `task_no_data_intr':
> drivers/ide/idedriver.o(.text+0x9f1): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `flagged_task_no_data_intr':
> drivers/ide/idedriver.o(.text+0x14c7): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `ide_cmd_ioctl':
> drivers/ide/idedriver.o(.text+0x23e0): undefined reference to `set_transfer'
> drivers/ide/idedriver.o(.text+0x23fc): undefined reference to `ide_ata66_check'
> drivers/ide/idedriver.o(.text+0x24a7): undefined reference to `ide_driveid_update'
> drivers/ide/idedriver.o: In function `check_dma_crc':
> drivers/ide/idedriver.o(.text+0x2fc3): undefined reference to `ide_auto_reduce_xfer'
> drivers/ide/idedriver.o: In function `ide_dump_status':
> drivers/ide/idedriver.o(.text+0x34c8): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `drive_cmd_intr':
> drivers/ide/idedriver.o(.text+0x3b21): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `ide_wait_stat':
> drivers/ide/idedriver.o(.text+0x3cd5): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `ide_do_request':
> drivers/ide/idedriver.o(.text+0x42c9): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `ide_intr':
> drivers/ide/idedriver.o(.text+0x48f3): undefined reference to `ide__sti'
> drivers/ide/idedriver.o: In function `report_drive_dmaing':
> drivers/ide/idedriver.o(.text+0x784a): undefined reference to `eighty_ninty_three'
> drivers/ide/idedriver.o(.text+0x789e): undefined reference to `eighty_ninty_three'
> drivers/ide/idedriver.o: In function `config_drive_for_dma':
> drivers/ide/idedriver.o(.text+0x79ce): undefined reference to `eighty_ninty_three'
> drivers/ide/idedriver.o(.text+0x79fe): undefined reference to `eighty_ninty_three'
> drivers/ide/idedriver.o: In function `via_set_drive':
> drivers/ide/idedriver.o(.text+0x91a8): undefined reference to `ide_config_drive_speed'
> drivers/ide/idedriver.o: In function `actual_try_to_identify':
> drivers/ide/idedriver.o(.text+0xaaec): undefined reference to `ide__sti'
> make: *** [vmlinux] Error 1
> 
> This comes at the final linking stage.
> 
> Thanks for the great stuff Andre.
> 
> Josh McKinney
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

