Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276014AbRJBJ42>; Tue, 2 Oct 2001 05:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276010AbRJBJ4K>; Tue, 2 Oct 2001 05:56:10 -0400
Received: from ns.ithnet.com ([217.64.64.10]:1038 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S275999AbRJBJz5>;
	Tue, 2 Oct 2001 05:55:57 -0400
Date: Tue, 2 Oct 2001 11:56:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem compiling aic7xxx_old.c in 2.4.11-pre2
Message-Id: <20011002115620.636a7c9b.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

FYI:



ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o
scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o
scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
aic7xxx_old.c:11966: parse error before string constant
aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
`MODULE_LICENSE'
aic7xxx_old.c:11966: warning: function declaration isn't a prototype
aic7xxx_old.c:11966: warning: data definition has no type or storage class
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.10/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.10/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.10/drivers'
make: *** [_dir_drivers] Error 2


Regards,
Stephan
