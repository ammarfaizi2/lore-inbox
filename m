Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424363AbWLBTyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424363AbWLBTyq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424365AbWLBTyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:54:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:34379 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424363AbWLBTyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:54:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type;
        b=P02TFlrPtofrtQvT2duxW/J0alJKIdbmvvK7RBhaX1i3bjzR/cmhmtpN074/pWE9RYOGOpdkWkMbJ8Zdwu0JQfiLPrmUXdbYEZEBzOlyR4IV2tbWACfiy3JG+E8+WnOki5qultPcrZIOGDWeSIj5Di4RH3Y0RoU2aoCPLdl4GwI=
Message-ID: <4571D9FE.2050107@gmail.com>
Date: Sat, 02 Dec 2006 20:54:38 +0100
From: Matthijs <thotter@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------060507050806020808040504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060507050806020808040504
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> There it finally is (or rather - I'm currently uploading the tar-file and 
> patches, and the mirrors are hopefully busily pushing out the git tree 
> that is already updated).
> 
> There's not a lot to be said about the changes since -rc6: the shortlog 
> (appended) tells the whole story, and it's really mostly a lot of 
> one-liners or other really small changes. Bugs fixed, but nothing that 
> stands out in my mind.
> 
> So go get it. It's one of those rare "perfect" kernels. So if it doesn't 
> happen to compile with your config (or it does compile, but then does 
> unspeakable acts of perversion with your pet dachshund), you can rest easy 
> knowing that it's all your own d*mn fault, and you should just fix your 
> evil ways.
> 
> You could send me and the kernel mailing list a note about it anyway, of 
> course. (And perhaps pictures, if your dachshund is involved. Not that 
> we'd be interested, of course. No. Just so that we'd know to avoid it next 
> time).
> 
> 			Linus
> 
> ---
> Adrian Bunk (2):
>       [SCSI] psi240i.c: fix an array overrun
>       [PATCH] drivers/rtc/rtc-rs5c372.c: fix a NULL dereference
> 
> Akinobu Mita (8):
>       [PATCH] dell_rbu: fix error check
>       debugfs: check return value correctly
>       [PATCH] fix copy_process() error check
>       [PATCH] tlclk: fix platform_device_register_simple() error check
>       [NET]: Fix kfifo_alloc() error check.
>       selinux: fix dentry_open() error check
>       [PATCH] fix create_write_pipe() error check
>       [PATCH] ecryptfs: fix crypto_alloc_blkcipher() error check
> 
> Alan Stern (2):
>       OHCI: disallow autostop when wakeup is not available
>       USB: OHCI: fix root-hub resume bug
> 
> Alex Sanks (1):
>       USB: ipaq: Add HTC Modem Support
> 
> Alexey Dobriyan (4):
>       [PATCH] Don't give bad kprobes example aka ") < 0))" typo
>       [PATCH] i2c-ixp4xx: fix ") != 0))" typo
>       [PATCH] reiserfs: fmt bugfix
>       [PATCH] Enforce "unsigned long flags;" when spinlocking
> 
> Amol Lad (1):
>       W1: ioremap balanced with iounmap
> 
> Andi Kleen (5):
>       [PATCH] x86-64: Fix C3 timer test
>       [PATCH] x86-64: Fix vsyscall.c compilation on UP
>       [PATCH] x86-64: Fix warning in io_apic.c
>       [PATCH] i386: Fix compilation with UP genericarch
>       [PATCH] x86-64: Use stricter in process stack check for unwinder
> 
> Andrew Morton (1):
>       [IA64] irqs: use `name' not `typename'
> 
> Andrew de Quincey (3):
>       V4L/DVB (4831): Fix tuning on older budget DVBS cards.
>       V4L/DVB (4832): Fix uninitialised variable in dvb_frontend_swzigzag
>       V4L/DVB (4874): Fix oops on symbol rate==0
> 
> Arjan van de Ven (1):
>       [PATCH] lockdep: spin_lock_irqsave_nested()
> 
> Arnaud Giersch (1):
>       [PATCH] parport: fix compilation failure
> 
> Benjamin Herrenschmidt (1):
>       [PATCH] Fix radeon DDC regression
> 
> Brian King (1):
>       [PATCH] libata: Fixup ata_sas_queuecmd to handle __ata_scsi_queuecmd failure
> 
> Bryan O'Sullivan (2):
>       [PATCH] IB/ipath - fix driver build for platforms with PCI, but not HT
>       IB/ipath: Depend on CONFIG_NET
> 
> Catalin Marinas (1):
>       [PATCH] Fix device_attribute memory leak in device_del
> 
> Chris Wright (1):
>       [PATCH] bridge: fix possible overflow in get_fdb_entries
> 
> Clemens Ladisch (1):
>       [ALSA] rtctimer: handle RTC interrupts with a tasklet
> 
> Dan Williams (1):
>       [ARM] 3942/1: ARM: comment: consistent_sync should not be called directly
> 
> Daniel Ritz (2):
>       [PATCH] pcmcia: fix 'rmmod pcmcia' with unbound devices
>       [PATCH] fix "pcmcia: fix 'rmmod pcmcia' with unbound devices"
> 
> Dave Jones (3):
>       [PATCH] Fix CPU_FREQ_GOV_ONDEMAND=y compile error
>       [PATCH] Correct bound checking from the value returned from _PPC method.
>       [PATCH] add missing libsas include to fix s390 compilation.
> 
> David Brownell (3):
>       [PATCH] Documentation/rtc.txt updates (for rtc class)
>       [PATCH] rtc framework handles periodic irqs
>       [PATCH] rtc class locking bugfixes
> 
> David Chinner (1):
>       [XFS] Stale the correct inode when freeing clusters.
> 
> David Howells (1):
>       [PATCH] AFS: Amend the AFS configuration options
> 
> David L Stevens (1):
>       [IGMP]: Fix IGMPV3_EXP() normalization bit shift value.
> 
> David S. Miller (2):
>       [BLUETOOTH]: Fix unaligned access in hci_send_to_sock.
>       [NET]: Fix MAX_HEADER setting.
> 
> David Weinehall (1):
>       [PATCH] Update my CREDITS entry
> 
> Dennis Stosberg (1):
>       aoe: Add forgotten NULL at end of attribute list in aoeblk.c
> 
> Douglas Gilbert (1):
>       [SCSI] sg: fix incorrect last scatg length
> 
> Eric Sandeen (1):
>       [PATCH] hfs_fill_super returns success even if no root inode
> 
> Faidon Liambotis (1):
>       [NETFILTER]: H.323 conntrack: fix crash with CONFIG_IP_NF_CT_ACCT
> 
> Francois Romieu (1):
>       [PATCH] r8169: Fix iteration variable sign
> 
> Frank Sievertsen (1):
>       USB: ftdi driver pid for dmx-interfaces
> 
> Gary Zambrano (1):
>       [TG3]: Increase 5906 firmware poll time.
> 
> Greg Ungerer (1):
>       [PATCH] m68knommu: fix up for the irq_handler_t changes
> 
> Hans Verkuil (1):
>       V4L/DVB (4885): Improve saa711x check
> 
> Ingo Molnar (7):
>       [IA64] typename -> name conversion
>       [IA64] use generic_handle_irq()
>       [PATCH] x86_64: fix CONFIG_CC_STACKPROTECTOR build bug
>       [PATCH] x86_64: stack unwinder crash fix
>       [PATCH] i386/x86_64: ACPI cpu_idle_wait() fix
>       [PATCH] lockdep: fix static keys in module-allocated percpu areas
>       [PATCH] x86_64: fix 'earlyprintk=...,keep' regression
> 
> Ira Snyder (1):
>       V4L/DVB (4849): Add missing spin_unlock to saa6588 decoder driver
> 
> Ira W. Snyder (1):
>       [TG3]: Add missing unlock in tg3_open() error path.
> 
> Jamal Hadi Salim (2):
>       [XFRM]: Sub-policies broke policy events
>       [XFRM]: nlmsg length not computed correctly in the presence of subpolicies
> 
> James Courtier-Dutton (1):
>       [ALSA] snd-emu10k1: Fix capture for one variant.
> 
> Jan Beulich (1):
>       [PATCH] x86-64: work around gcc4 issue with -Os in Dwarf2 stack unwind
> 
> Jan Mate (1):
>       USB Storage: unusual_devs.h entry for Sony Ericsson P990i
> 
> Jan-Benedict Glaw (1):
>       lkkbd: Remove my old snail-mail address
> 
> Jaroslav Kysela (1):
>       [ALSA] version 1.0.13
> 
> Jason Gaston (1):
>       [PATCH] ahci: AHCI mode SATA patch for Intel ICH9
> 
> Jean Delvare (3):
>       [SCSI] gdth: Fix && typos
>       [PATCH] Fix i2c-ixp4xx compile (missing brace)
>       [6PACK]: Masking bug in 6pack driver.
> 
> Jeff Garzik (1):
>       [PATCH] scx200_acb: handle PCI errors
> 
> Jeremy Higdon (1):
>       [PATCH] sgiioc4: Disable module unload
> 
> Joakim Tjernlund (1):
>       [PATCH] Fix Intel/Sharp command set erase suspend bug
> 
> John Heffner (1):
>       [TCP]: Fix up sysctl_tcp_mem initialization.
> 
> John W. Linville (1):
>       [ALSA] hda: fix typo for xw4400 PCI sub-ID
> 
> Julien BLACHE (1):
>       USB: hid-core: Add quirk for new Apple keyboard/trackpad
> 
> Kim Phillips (3):
>       [POWERPC] Revert "[POWERPC] Enable generic rtc hook for the MPC8349 mITX"
>       [POWERPC] Revert "[POWERPC] Add powerpc get/set_rtc_time interface to new generic rtc class"
>       [POWERPC] Fix ucc_geth of_device discovery on mpc832x
> 
> Kjell Myksvoll (1):
>       USB: ftdi_sio: adds vendor/product id for a RFID construction kit
> 
> Kristoffer Ericson (1):
>       [ARM] 3941/1: [Jornada7xx] - Addition to MAINTAINERS
> 
> Kyle McMartin (1):
>       [PATCH] Fix incorrent type of flags in <asm/semaphore.h>
> 
> Lachlan McIlroy (1):
>       [XFS] Fix uninitialized br_state and br_startoff in
> 
> Laurent Pinchart (1):
>       USB: Fixed outdated usb_get_device_descriptor() documentation
> 
> Linus Torvalds (10):
>       Fix generic fb_ddc i2c edid probe msg
>       x86: be more careful when walking back the frame pointer chain
>       Revert "ACPI: created a dedicated workqueue for notify() execution"
>       Add "pure_initcall" for static variable initialization
>       Don't call "note_interrupt()" with irq descriptor lock held
>       [AGP] Fix intel 965 AGP memory mapping function
>       [AGP] Allocate AGP pages with GFP_DMA32 by default
>       Revert "[PATCH] Enforce "unsigned long flags;" when spinlocking"
>       Fix 'ALIGN()' macro, take 2
>       Linux 2.6.19
> 
> Luca Risolia (1):
>       V4L/DVB (4865): Fix: Slot 0 not NULL on disconnecting SN9C10x PC Camera
> 
> Luck, Tony (1):
>       [IA64] a fix towards allmodconfig build
> 
> Manuel Lauss (1):
>       [PATCH] make au1xxx-ide compile again
> 
> Marcel Holtmann (5):
>       [Bluetooth] Attach low-level connections to the Bluetooth bus
>       [Bluetooth] Handling pending connect attempts after inquiry
>       [Bluetooth] Check if RFCOMM session is still attached to the TTY
>       [Bluetooth] Always include MTU in L2CAP config responses
>       [Bluetooth] Ignore L2CAP config requests on disconnect
> 
> Mariusz Kozlowski (2):
>       USB: auerswald possible memleak fix
>       [PATCH] usb: ati remote memleak fix
> 
> Martin Michlmayr (1):
>       [ARM] 3933/1: Source drivers/ata/Kconfig
> 
> Masahide NAKAMURA (1):
>       [XFRM] STATE: Fix to respond error to get operation if no matching entry exists.
> 
> Matt Porter (1):
>       [ALSA] hda: fix sigmatel dell system detection
> 
> Mel Gorman (1):
>       [PATCH] x86_64: fix bad page state in process 'swapper'
> 
> Michael Chan (1):
>       [TG3]: Disable TSO on 5906 if CLKREQ is enabled.
> 
> Michael Halcrow (2):
>       [PATCH] eCryptfs: dput() lower d_parent on rename
>       [PATCH] eCryptfs: CIFS nlink fixes
> 
> Michael S. Tsirkin (1):
>       IPoIB: Clear high octet in QP number
> 
> Mike Christie (2):
>       [SCSI] iscsi_tcp: fix xmittask oops
>       [SCSI] iscsi class: update version
> 
> Miklos Szeredi (1):
>       [PATCH] fuse: fix Oops in lookup
> 
> Milan Svoboda (1):
>       [ARM] 3943/1: share declaration of struct pxa2xx_udc_mach_info between multiple platforms
> 
> Muli Ben-Yehuda (1):
>       [PATCH] x86-64: increase PHB1 split transaction timeout
> 
> OGAWA Hirofumi (2):
>       [PATCH] fat: add fat_getattr()
>       [PATCH] Fix strange size check in __get_vm_area_node()
> 
> Olaf Hering (2):
>       [PATCH] set default video mode on PowerBook Wallstreet
>       USB: correct keymapping on Powerbook built-in USB ISO keyboards
> 
> Olaf Kirch (1):
>       [UDP]: Make udp_encap_rcv use pskb_may_pull
> 
> Oliver Endriss (1):
>       V4L/DVB (4840): Budget: diseqc_method module parameter for cards with subsystem-id 13c2:1003
> 
> Paolo 'Blaisorblade' Giarrusso (1):
>       [PATCH] uml: make execvp safe for our usage
> 
> Patrick McHardy (5):
>       [NETFILTER]: nfnetlink_log: fix byteorder of NFULA_SEQ_GLOBAL
>       [NETFILTER]: Use pskb_trim in {ip,ip6,nfnetlink}_queue
>       [NETFILTER]: ip6_tables: use correct nexthdr value in ipv6_find_hdr()
>       [NETFILTER]: ctnetlink: fix reference count leak
>       [NETFILTER]: ipt_REJECT: fix memory corruption
> 
> Paul Bonser (1):
>       [NET]: Re-fix of doc-comment in sock.h
> 
> Paul Mackerras (1):
>       [ALSA] Enable stereo line input for TAS codec
> 
> Pete Wyckoff (2):
>       [SCSI] iscsi: always release crypto
>       [SCSI] iscsi: add newlines to debug messages
> 
> Peter Zijlstra (1):
>       [IRDA]: Lockdep fix.
> 
> Phil Dibowitz (1):
>       USB: Fix UCR-61S2B unusual_dev entry
> 
> Phillip Susi (1):
>       [PATCH] Update udf documentation to reflect current state of read/write support
> 
> Ralf Baechle (2):
>       [MIPS] Fix Bonito bootup message.
>       [MIPS] Do topology_init even on uniprocessor kernels.
> 
> Randy Dunlap (2):
>       [PATCH] ftape: fix printk format warnings
>       [PATCH] debugfs: add header file
> 
> Robin Holt (1):
>       [IA64] bte_unaligned_copy() transfers one extra cache line.
> 
> Roman Zippel (2):
>       [PATCH] qconf: fix uninitialsied member
>       [PATCH] fix menuconfig colours with TERM=vt100
> 
> Russell King (5):
>       [ARM] Remove PM_LEGACY=y from selected ARM defconfigs
>       [ARM] Remove OP_MAX_COUNTER
>       [ARM] ebsa110: fix warnings generated by asm/arch/io.h
>       [ARM] Add PM_LEGACY defaults
>       [ARM] Export smp_call_function()
> 
> Sergey Vlasov (1):
>       usb-storage: Remove duplicated unusual_devs.h entries for Sony Ericsson P990i
> 
> Takashi Iwai (1):
>       [ALSA] Fix hang-up at disconnection of usb-audio
> 
> Tejun Heo (2):
>       [PATCH] scsi: clear garbage after CDBs on SG_IO
>       [PATCH] libata: don't schedule EH on wcache on/off if old EH
> 
> Thiemo Seufer (1):
>       [MIPS] Hack for SB1 cache issues
> 
> Thomas Chou (1):
>       [PATCH] initramfs: handle more than one source dir or file list
> 
> Toralf Foerster (1):
>       [PATCH] fix build error for HISAX_NETJET
> 
> Vasily Tarasov (1):
>       [PATCH] mounstats NULL pointer dereference
> 
> Vitaly Wool (3):
>       [ARM] 3857/2: pnx4008: add devices' registration
>       [PATCH] pnx4008: rename driver
>       [PATCH] pnx4008:fix NULL dereference in rgbfb
> 
> Vivek Goyal (2):
>       [PATCH] x86_64: Align data segment to PAGE_SIZE boundary
>       [PATCH] x86_64: Align data segment to PAGE_SIZE boundary
> 
> YOSHIFUJI Hideaki (4):
>       [IPV6] ROUTE: Try to use router which is not known unreachable.
>       [IPV6] ROUTE: Prefer reachable nexthop only if the caller requests.
>       [IPV6] ROUTE: Do not enable router reachability probing in router mode.
>       [IPV6]: Fix address/interface handling in UDP and DCCP, according to the scoping architecture.
> 
> Yasunori Goto (1):
>       [PATCH] x86_64: fix memory hotplug build with NUMA=n
> 
> Yasuyuki Kozakai (6):
>       [NETFILTER]: ip6_tables: fixed conflicted optname for getsockopt
>       [IPV6] IP6TUNNEL: Delete all tunnel device when unloading module.
>       [IPV6] IP6TUNNEL: Add missing nf_reset() on input path.
>       [NETFILTER]: nfctnetlink: assign helper to newly created conntrack
>       [NETFILTER]: nf_conntrack: fix the race on assign helper to new conntrack
>       [NETFILTER]: conntrack: fix refcount leak when finding expectation
> 
> Yoichi Yuasa (1):
>       [CRYPTO] api: Remove one too many semicolon
> 
> Zhang, Yanmin (2):
>       [PATCH] ipmi: use platform_device_add() instead of platform_device_register() to register device allocated dynamically
>       [PATCH] some irq_chip variables point to NULL
> 
> adam radford (1):
>       [SCSI] 3ware 9000 add support for 9650SE
> 
> malahal@us.ibm.com (2):
>       [SCSI] aic94xx SCSI timeout fix
>       [SCSI] aic94xx SCSI timeout fix: SMP retry fix.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

make modules gives me these warnings in modpost and then errors out:
WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
WARNING: "tosh_smm" [drivers/video/neofb.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

After applying this patch (post attached):
http://marc.theaimsgroup.com/?l=linux-kernel&m=116413732511394&w=2
the tosh_smm warning is gone and the kernel compiles. The other warning
is still there though.

Matthijs van Otterdijk

--------------060507050806020808040504
Content-Type: text/plain;
 name="tosh_smm-fix.mail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tosh_smm-fix.mail"

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_TOSHIBA=y and CONFIG_FB_NEOMAGIC=m, tosh_smm() needs
to be exported for neofb to use it.

WARNING: "tosh_smm" [drivers/video/neofb.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/toshiba.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2619-rc6g4.orig/drivers/char/toshiba.c
+++ linux-2619-rc6g4/drivers/char/toshiba.c
@@ -249,6 +249,7 @@ int tosh_smm(SMMRegisters *regs)
 
 	return eax;
 }
+EXPORT_SYMBOL(tosh_smm);
 
 
 static int tosh_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,


---
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--------------060507050806020808040504--
