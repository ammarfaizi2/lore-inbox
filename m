Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbUJ1UcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUJ1UcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbUJ1Uan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:30:43 -0400
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:41011 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S262895AbUJ1U0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:26:53 -0400
Message-ID: <418155F7.3010105@planet.nl>
Date: Thu, 28 Oct 2004 22:26:31 +0200
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel-2.6.10-rc1-mm1 compile issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel Developers,

I'm trying to get kernel 2.6.10-rc1-mm1 into life. The compile of 
2.6.10-rc1 goes fine but when I apply the patch for 2.6.10-rc1-mm1 and 
recompile the kernel I get some errors which I can't explain why they 
happen. A lot of the messages are warnings and probably mostly harmless 
but at the end the compile stops dead in it's tracks. I've added the 
logs of the compile at the end of this email.

I'm running gcc-3.4.2, glibc-2.3.3, kernel headers-2.6.8.1.

Can anybody tell me if I'm doing someting wrong ?

Thanks in advance,

Stef


Part of the terminal output:

fs/binfmt_elf.c:758: warning: ignoring return value of `clear_user', 
declared wi
th attribute warn_unused_result
fs/binfmt_elf.c: In function `fill_psinfo':
fs/binfmt_elf.c:1218: warning: ignoring return value of 
`copy_from_user', declar
ed with attribute warn_unused_result
fs/reiser4/page_cache.c: In function `drop_page':
fs/reiser4/page_cache.c:763: warning: implicit declaration of function 
`delete_f
rom_page_cache'
fs/reiser4/repacker.c:400: warning: 'wait_repacker_completion' defined 
but not u
sed
fs/reiser4/repacker.c:595: warning: 'init_repacker_sysfs_interface' 
defined but
not used
fs/reiser4/repacker.c:612: warning: 'done_repacker_sysfs_interface' 
defined but
not used
drivers/char/vt.c: In function `vc_allocate':
drivers/char/vt.c:748: warning: `pm_register' is deprecated (declared at 
include
/linux/pm.h:106)
drivers/char/agp/backend.c: In function `agp_add_bridge':
drivers/char/agp/backend.c:281: warning: `inter_module_register' is 
deprecated (
declared at include/linux/module.h:577)
drivers/char/agp/backend.c: In function `agp_remove_bridge':
drivers/char/agp/backend.c:301: warning: `inter_module_unregister' is 
deprecated
 (declared at include/linux/module.h:578)
In file included from drivers/char/drm/drm_core.h:25,
                 from drivers/char/drm/radeon_drv.c:41:
drivers/char/drm/drm_agpsupport.h: In function `radeon_agp_uninit':
drivers/char/drm/drm_agpsupport.h:431: warning: `inter_module_put' is 
deprecated
 (declared at include/linux/module.h:582)
In file included from drivers/char/drm/drm_core.h:39,
                 from drivers/char/drm/radeon_drv.c:41:
drivers/char/drm/drm_stub.h: In function `radeon_stub_putminor':
drivers/char/drm/drm_stub.h:148: warning: `inter_module_put' is 
deprecated (decl
ared at include/linux/module.h:582)
drivers/char/drm/drm_stub.h:150: warning: `inter_module_unregister' is 
deprecate
d (declared at include/linux/module.h:578)
drivers/char/drm/drm_stub.h: In function `radeon_stub_register':
drivers/char/drm/drm_stub.h:206: warning: `inter_module_register' is 
deprecated
(declared at include/linux/module.h:577)
drivers/char/drm/drm_stub.h:216: warning: `inter_module_unregister' is 
deprecate
d (declared at include/linux/module.h:578)
drivers/char/drm/radeon_state.c: In function `radeon_cp_dispatch_texture':
drivers/char/drm/radeon_state.c:1443: warning: ignoring return value of 
`copy_to
_user', declared with attribute warn_unused_result
drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user':
drivers/ide/ide-tape.c:2613: warning: ignoring return value of 
`copy_from_user',
 declared with attribute warn_unused_result
drivers/ide/ide-tape.c: In function `idetape_copy_stage_to_user':
drivers/ide/ide-tape.c:2640: warning: ignoring return value of 
`copy_to_user', d
eclared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic7xxx_osm.c: In function `ahc_linux_register_host':
drivers/scsi/aic7xxx/aic7xxx_osm.c:1744: warning: ignoring return value 
of `scsi
_add_host', declared with attribute warn_unused_result
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c: In function 
`ahc_linux_pci_dev_probe':
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:229: warning: large integer 
implicitly tr
uncated to unsigned type
drivers/scsi/osst.c:85: warning: `MODULE_PARM_' is deprecated (declared 
at inclu
de/linux/module.h:562)
drivers/scsi/osst.c:88: warning: `MODULE_PARM_' is deprecated (declared 
at inclu
de/linux/module.h:562)
drivers/scsi/osst.c:91: warning: `MODULE_PARM_' is deprecated (declared 
at inclu
de/linux/module.h:562)
sound/core/init.c: In function `snd_card_set_dev_pm_callback':
sound/core/init.c:776: warning: `pm_register' is deprecated (declared at 
include
/linux/pm.h:106)
fs/built-in.o(.text+0x7ac23): In function `drop_page':
: undefined reference to `delete_from_page_cache'
make: *** [.tmp_vmlinux1] Error 1

Part of the compile log:
  AR      lib/lib.a
  LD      arch/i386/lib/built-in.o
  CC      arch/i386/lib/bitops.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/dec_and_lock.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/mmx.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1


