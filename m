Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312099AbSCQSnW>; Sun, 17 Mar 2002 13:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312098AbSCQSnN>; Sun, 17 Mar 2002 13:43:13 -0500
Received: from gear.torque.net ([204.138.244.1]:50437 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S312094AbSCQSnJ>;
	Sun, 17 Mar 2002 13:43:09 -0500
Message-ID: <3C94E400.99DCBC12@torque.net>
Date: Sun, 17 Mar 2002 13:44:16 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.7-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.6-dj1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> This one hasn't had any testing beyond "it compiles"

Compiled here but didn't link (SMP) :-(
 page_cache_release undefined multiple times in mm/mm.o


There are over 30 scsi subsystem patches backed up in
your tree. Some are over 2 months old. Could
some (or perhaps all) of them get promoted to the
main tree? It is very difficult to write further patches
against the scsi subsystem with this sort of backlog.

Other subsystems (e.g. usb and ieee1394) might appreciate
some of those changes since they asked for them.

Doug Gilbert

------------------------------------------
patch-2.5.7-pre2 shows _one_ file patched in the
scsi subsystem:
  patching file drivers/scsi/ide-scsi.c

patch-2.5.6-dj1 has the following list. Some of them
are superficial (e.g. "s/then/than/") but most have
substance:
  patching file drivers/scsi/3w-xxxx.c
  patching file drivers/scsi/3w-xxxx.h
  patching file drivers/scsi/53c7,8xx.c
  patching file drivers/scsi/53c7xx.c
  patching file drivers/scsi/Config.help
  patching file drivers/scsi/Config.in
  patching file drivers/scsi/Makefile
  patching file drivers/scsi/README.st
  patching file drivers/scsi/aacraid/Makefile
  patching file drivers/scsi/aacraid/README
  patching file drivers/scsi/aacraid/TODO
  patching file drivers/scsi/aacraid/aachba.c
  patching file drivers/scsi/aacraid/aacraid.h
  patching file drivers/scsi/aacraid/commctrl.c
  patching file drivers/scsi/aacraid/comminit.c
  patching file drivers/scsi/aacraid/commsup.c
  patching file drivers/scsi/aacraid/dpcsup.c
  patching file drivers/scsi/aacraid/linit.c
  patching file drivers/scsi/aacraid/rx.c
  patching file drivers/scsi/aacraid/sap1sup.c
  patching file drivers/scsi/advansys.c
  patching file drivers/scsi/aha1542.c
  patching file drivers/scsi/aic7xxx/aic7xxx_linux.c
  patching file drivers/scsi/aic7xxx/aicasm/aicdb.h
  patching file drivers/scsi/aic7xxx_old.c
  patching file drivers/scsi/cpqfcTSstructs.h
  patching file drivers/scsi/dtc.c
  patching file drivers/scsi/eata.c
  patching file drivers/scsi/fdomain.c
  patching file drivers/scsi/g_NCR5380.c
  patching file drivers/scsi/g_NCR5380.h
  patching file drivers/scsi/i60uscsi.c
  patching file drivers/scsi/ibmmca.c
  patching file drivers/scsi/ide-scsi.c
  patching file drivers/scsi/imm.c
  patching file drivers/scsi/ips.c
  patching file drivers/scsi/megaraid.c
  patching file drivers/scsi/mesh.c
  patching file drivers/scsi/osst.c
  patching file drivers/scsi/osst.h
  patching file drivers/scsi/pas16.c
  patching file drivers/scsi/pci2000.c
  patching file drivers/scsi/pcmcia/aha152x_stub.c
  patching file drivers/scsi/pcmcia/fdomain_stub.c
  patching file drivers/scsi/pcmcia/qlogic_stub.c
  patching file drivers/scsi/ppa.c
  patching file drivers/scsi/scsi.c
  patching file drivers/scsi/scsi.h
  patching file drivers/scsi/scsi_debug.c
  patching file drivers/scsi/scsi_debug.h
  patching file drivers/scsi/scsi_error.c
  patching file drivers/scsi/scsi_merge.c
  patching file drivers/scsi/scsi_scan.c
  patching file drivers/scsi/sd.c
  patching file drivers/scsi/sg.c
  patching file drivers/scsi/sgiwd93.c
  patching file drivers/scsi/sr.c
  patching file drivers/scsi/st.c
  patching file drivers/scsi/sun3_scsi.c
  patching file drivers/scsi/sym53c8xx_2/sym_hipd.c
  patching file drivers/scsi/sym53c8xx_defs.h
  patching file drivers/scsi/t128.c
  patching file drivers/scsi/tmscsim.c
  patching file drivers/scsi/u14-34f.c
  patching file drivers/scsi/wd33c93.c
