Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSHBIRZ>; Fri, 2 Aug 2002 04:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318752AbSHBIRZ>; Fri, 2 Aug 2002 04:17:25 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:5848 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318751AbSHBIRZ>; Fri, 2 Aug 2002 04:17:25 -0400
Message-ID: <3D4A40C3.AF47AA62@wanadoo.fr>
Date: Fri, 02 Aug 2002 10:20:19 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.30 does not build cleanly
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following messages :

make[3]: Leaving directory `/usr/src/kernel-source-2.5.30/arch/i386/pci'
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/usr/src/linux/debian/tmp-image -r 2.5.30; fi
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/arch/i386/kernel/apm.o
depmod: 	cpu_gdt_table
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/block/floppy.o
depmod: 	elv_queue_empty
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/block/nbd.o
depmod: 	elv_queue_empty
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.5.30/kernel/drivers/scsi/scsi_mod.o
depmod: 	elv_queue_empty
make[2]: *** [_modinst_post] Erreur 1
make[2]: Leaving directory `/usr/src/kernel-source-2.5.30'
make[1]: *** [real_stamp_image] Erreur 2

----
Regards
	Jean-Luc
