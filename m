Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUBJUJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbUBJUJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:09:28 -0500
Received: from [24.108.240.248] ([24.108.240.248]:3426 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id S265592AbUBJUJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:09:05 -0500
Date: Tue, 10 Feb 2004 12:09:01 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200402102009.i1AK91T20554@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: Spelling in 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Relax, this is not a spelling patch.

I was curious how fast spelling errors flow into the kernel, so I
looked at the + lines in the 2.6.2 patch.  A few of the errors
already existed, but most of them are new.  It turns out that there
are around 200 new spelling errors in 2.6.2.

A "wether" (castrated goat) has appeared, along with a "Rusell" that
should be stamped out before it spreads.  Someone had a dreadful time
with "technology" and its variants, spelling it wrong 9 different ways.

Here's what I found:

File                                      Error            Should be          #
-------------------------------------------------------------------------------
Documentation/kernel-parameters.txt       Trigge           Trigger            1
Documentation/power/video.txt             carefull         careful            1
Documentation/s390/driver-model.txt       registerd        registered         1
Documentation/scsi/qla2xxx.revision.notes Consoldate       Consolidate        1
Documentation/scsi/qla2xxx.revision.notes disparite        disparate          1
Documentation/scsi/qla2xxx.revision.notes resouces         resources          1
Documentation/scsi/qla2xxx.revision.notes unecessary       unnecessary        1
Documentation/scsi/qla2xxx.revision.notes uneeded          unneeded           1
Documentation/sh/new-machine.txt          heirarchy        hierarchy          2
arch/i386/kernel/acpi/boot.c              recogznied       recognized         1
arch/ia64/sn/io/drivers/ioconfig_bus.c    Unabled          Unable             1
arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c    requred          required           1
arch/m68k/kernel/traps.c                  propably         probably           1
arch/m68knommu/kernel/module.c            postition        position           1
arch/ppc64/kernel/iSeries_IoMmTable.c     assiged          assigned           1
arch/ppc64/kernel/iSeries_IoMmTable.c     initalizes       initializes        1
arch/ppc64/kernel/iSeries_IoMmTable.h     Initalizes       Initializes        1
arch/ppc64/kernel/iSeries_IoMmTable.h     psuedo           pseudo             1
arch/ppc64/kernel/iSeries_VpdInfo.c       requrested       requested          1
arch/ppc64/kernel/process.c               dont             don't              1
arch/ppc64/kernel/setup.c                 dont             don't              1
arch/ppc64/kernel/signal.c                spurrious        spurious           1
arch/ppc64/kernel/signal.c                wether           whether            1
arch/ppc64/kernel/stab.c                  dont             don't              1
arch/ppc64/kernel/viopath.c               doesnt           doesn't            4
arch/ppc64/mm/hash_low.S                  Retreive         Retrieve           4
arch/ppc64/mm/init.c                      nonexistant      nonexistent        1
arch/s390/kernel/compat_signal.c          Alwys            Always             1
arch/s390/kernel/signal.c                 Alwys            Always             1
arch/s390/lib/uaccess.S                   cant't           can't              1
arch/s390/lib/uaccess64.S                 cant't           can't              1
arch/sh/Kconfig                           existance        existence          1
arch/sh/drivers/pci/ops-bigsur.c          Funtion          Function           1
arch/sh/drivers/pci/ops-dreamcast.c       existance        existence          1
arch/sh/drivers/pci/ops-snapgear.c        Funtion          Function           1
arch/sh/drivers/pci/pci-sh7751.c          exitst           exists             1
arch/sh/drivers/pci/pci-sh7751.c          genereated       generated          1
arch/sh/drivers/pci/pci-sh7751.c          intialization    initialization     1
arch/sh/drivers/pci/pci-sh7751.c          overruning       overrunning        1
arch/sh/drivers/pci/pci-sh7751.h          Funtion          Function           1
arch/sh/drivers/pci/pci-st40.h            Defintions       Definitions        1
arch/sh/kernel/cpu/sh4/sq.c               Infact           In fact            1
arch/x86_64/kernel/acpi/boot.c            recogznied       recognized         1
arch/x86_64/kernel/time.c                 everytime        every time         1
arch/x86_64/kernel/time.c                 interuppts       interrupts         1
drivers/base/class_simple.c               assiociated      associated         1
drivers/block/as-iosched.c                exitted          exited             1
drivers/block/as-iosched.c                guage            gauge              1
drivers/block/ll_rw_blk.c                 didnt            didn't             1
drivers/char/viocons.c                    wierd            weird              1
drivers/char/watchdog/machzwd.c           unconditionaly   unconditionally    1
drivers/i2c/busses/Kconfig                prefered         preferred          1
drivers/i2c/chips/asb100.c                suprise          surprise           1
drivers/i2c/chips/lm85.c                  Unrecgonized     Unrecognized       2
drivers/ieee1394/ohci1394.c               dont             don't              1
drivers/ieee1394/oui.db                   Compny           Company            1
drivers/ieee1394/oui.db                   Corperation      Corporation        1
drivers/ieee1394/oui.db                   Corportation     Corporation        1
drivers/ieee1394/oui.db                   Corpotation      Corporation        1
drivers/ieee1394/oui.db                   Develoment       Development        1
drivers/ieee1394/oui.db                   Enterpirse       Enterprise         1
drivers/ieee1394/oui.db                   Incoporation     Incorporation      1
drivers/ieee1394/oui.db                   Reserch          Research           1
drivers/ieee1394/oui.db                   TECHNOLGIES      TECHNOLOGIES       1
drivers/ieee1394/oui.db                   Tchnology        Technology         1
drivers/ieee1394/oui.db                   Technolgies      Technologies       1
drivers/ieee1394/oui.db                   Technoligy       Technology         1
drivers/ieee1394/oui.db                   Technoloiges     Technologies       1
drivers/ieee1394/oui.db                   Technonlogy      Technology         1
drivers/ieee1394/oui.db                   Techologies      Technologies       1
drivers/ieee1394/oui.db                   Techonology      Technology         1
drivers/ieee1394/oui.db                   Tehnology        Technology         1
drivers/ieee1394/oui.db                   resarch          research           1
drivers/ieee1394/oui.db                   telecomunication telecommunication  1
drivers/input/serio/i8042.c               conrtoller       controller         1
drivers/md/mktables.c                     Bostom           Boston             1
drivers/md/raid6.h                        Bostom           Boston             1
drivers/md/raid6algos.c                   Bostom           Boston             1
drivers/md/raid6int.uc                    Bostom           Boston             1
drivers/md/raid6main.c                    coverred         covered            1
drivers/md/raid6mmx.c                     Bostom           Boston             1
drivers/md/raid6recov.c                   Bostom           Boston             1
drivers/md/raid6sse1.c                    Bostom           Boston             1
drivers/md/raid6sse2.c                    Bostom           Boston             1
drivers/md/raid6test/test.c               Bostom           Boston             1
drivers/md/raid6x86.h                     Bostom           Boston             1
drivers/media/dvb/ttpci/av7110_v4l.c      comparision      comparison         1
drivers/media/video/bttv-gpio.c           intented         intended           1
drivers/media/video/cx88/cx88-core.c      enougth          enough             1
drivers/media/video/cx88/cx88-video.c     Threshholds      Thresholds         1
drivers/media/video/cx88/cx88-video.c     adaptibe         adaptive           1
drivers/media/video/cx88/cx88-video.c     interupts        interrupts         1
drivers/media/video/tuner.c               Initalization    Initialization     1
drivers/net/forcedeth.c                   Miscelaneous     Miscellaneous      1
drivers/net/forcedeth.c                   Substract        Subtract           1
drivers/net/irda/act200l-sir.c            Regsiter         Register           1
drivers/net/irda/girbil-sir.c             alread           already            1
drivers/net/irda/girbil-sir.c             emmited          emitted            1
drivers/net/irda/litelink-sir.c           avaiable         available          1
drivers/net/sk98lin/skge.c                Initalize        Initialize         1
drivers/net/sk98lin/skge.c                deattaches       detaches           1
drivers/net/sk98lin/skge.c                maintianed       maintained         1
drivers/net/sk98lin/skge.c                suitables        suitable           1
drivers/net/sk98lin/skproc.c              Transmited       Transmitted        2
drivers/net/tg3.c                         currupted        corrupted          1
drivers/net/wan/hd64572.h                 transmition      transmission       1
drivers/net/wireless/atmel.c              encyption        encryption         1
drivers/net/wireless/atmel.c              implemenents     implements         1
drivers/pci/pci.ids                       formely          formerly           1
drivers/pci/pci.ids                       usefull          useful             1
drivers/s390/block/dasd_eckd.c            Returnes         Returns            1
drivers/s390/char/fs3270.c                sucessfully      successfully       1
drivers/s390/char/raw3270.c               Heigth           Height             1
drivers/s390/char/raw3270.c               Sucessfully      Successfully       1
drivers/s390/char/tape_34xx.c             Cartdridge       Cartridge          1
drivers/s390/char/tape_34xx.c             cartdridge       cartridge          1
drivers/s390/char/tape_char.c             immediatly       immediately        1
drivers/s390/char/tape_core.c             Hutplug          Hotplug            1
drivers/s390/char/tape_std.c              sewuential       sequential         1
drivers/s390/char/tty3270.c               characeter       character          1
drivers/s390/char/tty3270.c               successfull      successful         1
drivers/s390/scsi/zfcp_erp.c              appropiate       appropriate        1
drivers/scsi/ips.c                        Utilites         Utilities          1
drivers/scsi/qla1280.c                    aboring          aborting           2
drivers/scsi/qla1280.c                    paramaters       parameters         1
drivers/scsi/qla1280.c                    quantites        quantities         3
drivers/scsi/qla2xxx/qla_def.h            accomodate       accommodate        1
drivers/scsi/qla2xxx/qla_def.h            adpaters         adapters           1
drivers/scsi/qla2xxx/qla_def.h            aquire           acquire            1
drivers/scsi/qla2xxx/qla_init.c           adapeter         adapter            1
drivers/scsi/qla2xxx/qla_init.c           asyncronous      asynchronous       1
drivers/scsi/qla2xxx/qla_init.c           discoverying     discovering        1
drivers/scsi/qla2xxx/qla_init.c           remainning       remaining          1
drivers/scsi/qla2xxx/qla_inline.h         occured          occurred           1
drivers/scsi/qla2xxx/qla_iocb.c           decriptors       descriptors        2
drivers/scsi/qla2xxx/qla_iocb.c           occured          occurred           2
drivers/scsi/qla2xxx/qla_isr.c            aynchronous      asynchronous       1
drivers/scsi/qla2xxx/qla_isr.c            hammmer          hammer             1
drivers/scsi/qla2xxx/qla_isr.c            occured          occurred           3
drivers/scsi/qla2xxx/qla_isr.c            recieved         received           1
drivers/scsi/qla2xxx/qla_os.c             Opertions        Operations         1
drivers/scsi/qla2xxx/qla_os.c             adpaters         adapters           1
drivers/scsi/qla2xxx/qla_os.c             paramaters       parameters         1
drivers/scsi/qla2xxx/qla_os.c             qeueue           queue              1
drivers/scsi/qla2xxx/qla_os.c             recieved         received           1
drivers/scsi/qla2xxx/qla_os.c             remainning       remaining          2
drivers/scsi/qla2xxx/qla_os.c             succeded         succeeded          2
drivers/scsi/qla2xxx/qla_os.c             unsued           unused             1
drivers/scsi/qla2xxx/qla_rscn.c           Retrive          Retrieve           3
drivers/scsi/qla2xxx/qla_rscn.c           descriptiors     descriptors        1
drivers/scsi/qla2xxx/qla_sup.c            recommeds        recommends         1
drivers/usb/gadget/file_storage.c         oonsistent       consistent         1
drivers/usb/gadget/pxa2xx_udc.c           dont             don't              1
drivers/usb/host/ohci-omap.c              Rusell           Russell            1
drivers/usb/media/w9968cf.c               paramater        parameter          1
drivers/usb/media/w9968cf.c               paramaters       parameters         1
drivers/usb/media/w9968cf.h               incative         inactive           1
drivers/usb/misc/emi62.c                  inialization     initialization     1
drivers/video/kyro/STG4000InitDevice.c    comparater       comparator         1
drivers/video/kyro/STG4000OverlayDevice.c factror          factor             1
drivers/video/kyro/STG4000OverlayDevice.c largets          largest            1
drivers/video/kyro/STG4000Reg.h           appropraite      appropriate        1
drivers/video/kyro/fbdev.c                horrizontal      horizontal         1
drivers/video/kyro/fbdev.c                infact           in fact            1
fs/afs/cell.c                             bizzare          bizarre            1
fs/xfs/linux/kmem.h                       recusive         recursive          1
fs/xfs/xfs_behavior.c                     Attemps          Attempts           1
fs/xfs/xfs_behavior.c                     postition        position           1
fs/xfs/xfs_behavior.h                     interpostion     interposition      1
include/asm-i386/byteorder.h              exhange          exchange           1
include/asm-ia64/sn/pci/pcibr_private.h   Dont             Don't              1
include/asm-ia64/sn/sn2/sn_private.h      gaurd            guard              1
include/asm-sparc/pgtsrmmu.h              tabes            tables             1
include/linux/videodev2.h                 excisting        existing           1
include/media/ir-common.h                 enougth          enough             1
include/video/kyro.h                      Usefull          Useful             1
kernel/fork.c                             dont             don't              1
net/ipv6/addrconf.c                       prefered         preferred          1
net/irda/irlap_event.c                    negociate        negotiate          1
net/irda/irlap_frame.c                    adjustement      adjustment         2
net/irda/irlap_frame.c                    begining         beginning          1
net/sctp/sm_make_chunk.c                  paramter         parameter          2
net/sctp/sm_make_chunk.c                  paramters        parameters         1
sound/oss/trident.c                       Begine           Begin              1
sound/oss/trident.c                       comsumed         consumed           1
sound/oss/trident.c                       dealed           dealt              1
sound/oss/trident.c                       defered          deferred           1
sound/oss/trident.c                       manangement      management         1
sound/oss/trident.c                       redundacy        redundancy         1
sound/oss/trident.c                       wehre            where              1
