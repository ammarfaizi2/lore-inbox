Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWFZU05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFZU05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWFZU04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:26:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21773 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750870AbWFZU0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:26:54 -0400
Date: Mon, 26 Jun 2006 22:26:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060626202651.GY23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:


Adrian Bunk:
      remove the bouncing email address of David Campbell
      move acknowledgment for Mark Adler to CREDITS

Andreas Mohr:
      spelling fixes

Egry Gabor:
      i386: Trivial typo fixes

Jesper Juhl:
      Clean up 'inline is not at beginning' warnings for usb storage

Lee Revell:
      fix paniced->panicked typos

Matthew Martin:
      ixj: make ixj_set_tone_off() static

Michael Hayes:
      Spelling fixes for Documentation/atomic_ops.txt

olecom@mail.ru:
      typo fixes

Tobias Klauser:
      Storage class should be first


 CREDITS                                    |    5 +++
 Documentation/DocBook/kernel-locking.tmpl  |    2 -
 Documentation/atomic_ops.txt               |   28 ++++++++++-----------
 Documentation/driver-model/overview.txt    |    2 -
 Documentation/kdump/gdbmacros.txt          |    2 -
 Documentation/scsi/ppa.txt                 |    2 -
 arch/i386/Kconfig                          |    2 -
 arch/i386/Kconfig.cpu                      |    2 -
 arch/i386/kernel/cpu/cyrix.c               |    2 -
 arch/i386/kernel/crash.c                   |    2 -
 arch/i386/kernel/i8259.c                   |    2 -
 arch/i386/kernel/machine_kexec.c           |    4 +--
 arch/mips/momentum/ocelot_g/gt-irq.c       |    4 +--
 arch/mips/sgi-ip22/ip22-reset.c            |    2 -
 arch/mips/sgi-ip32/ip32-reset.c            |   12 ++++-----
 arch/powerpc/kernel/crash.c                |    2 -
 arch/powerpc/kernel/machine_kexec_32.c     |    4 +--
 arch/powerpc/platforms/cell/spufs/switch.c |    2 -
 arch/powerpc/platforms/pseries/eeh_cache.c |    2 -
 arch/ppc/kernel/machine_kexec.c            |    4 +--
 arch/s390/kernel/machine_kexec.c           |    4 +--
 arch/s390/kernel/vtime.c                   |    2 -
 arch/sh/kernel/machine_kexec.c             |    4 +--
 arch/um/drivers/ubd_kern.c                 |    2 -
 arch/x86_64/kernel/crash.c                 |    2 -
 arch/x86_64/kernel/i8259.c                 |    2 -
 arch/x86_64/kernel/machine_kexec.c         |    4 +--
 arch/x86_64/kernel/smp.c                   |    2 -
 block/as-iosched.c                         |    2 -
 block/ll_rw_blk.c                          |    4 +--
 drivers/atm/firestream.c                   |    2 -
 drivers/char/agp/amd-k7-agp.c              |    2 -
 drivers/char/agp/ati-agp.c                 |    2 -
 drivers/char/agp/efficeon-agp.c            |    2 -
 drivers/char/ipmi/ipmi_msghandler.c        |    6 ++--
 drivers/char/rio/riointr.c                 |    2 -
 drivers/hwmon/asb100.c                     |    2 -
 drivers/hwmon/lm78.c                       |    2 -
 drivers/hwmon/lm80.c                       |    2 -
 drivers/hwmon/lm87.c                       |    2 -
 drivers/hwmon/sis5595.c                    |    2 -
 drivers/hwmon/smsc47m1.c                   |    2 -
 drivers/hwmon/w83627hf.c                   |    2 -
 drivers/hwmon/w83781d.c                    |    2 -
 drivers/hwmon/w83792d.c                    |    2 -
 drivers/ide/ide-disk.c                     |    2 -
 drivers/ide/ide-io.c                       |    2 -
 drivers/ieee1394/hosts.c                   |    2 -
 drivers/ieee1394/ieee1394_core.h           |    2 -
 drivers/isdn/divert/isdn_divert.c          |    2 -
 drivers/media/video/bt8xx/bttv-cards.c     |    2 -
 drivers/net/3c501.c                        |    4 +--
 drivers/net/irda/irport.c                  |    2 -
 drivers/net/pcmcia/smc91c92_cs.c           |    2 -
 drivers/net/wireless/ipw2100.c             |    2 -
 drivers/parport/parport_gsc.c              |    2 -
 drivers/parport/parport_gsc.h              |    2 -
 drivers/parport/parport_pc.c               |    2 -
 drivers/parport/procfs.c                   |    2 -
 drivers/pci/pci.c                          |    2 -
 drivers/s390/scsi/zfcp_erp.c               |   14 +++++-----
 drivers/scsi/NCR5380.c                     |    2 -
 drivers/scsi/advansys.c                    |    2 -
 drivers/scsi/dc395x.c                      |    2 -
 drivers/scsi/ibmmca.c                      |    8 +++---
 drivers/scsi/imm.c                         |    3 --
 drivers/scsi/imm.h                         |    2 -
 drivers/scsi/ips.c                         |    4 +--
 drivers/scsi/ppa.c                         |    2 -
 drivers/scsi/ppa.h                         |    2 -
 drivers/scsi/st.c                          |    2 -
 drivers/telephony/ixj.c                    |    2 -
 drivers/usb/storage/usb.h                  |    4 +--
 fs/9p/mux.c                                |    2 -
 fs/aio.c                                   |    2 -
 fs/jffs2/summary.c                         |    2 -
 fs/jfs/jfs_extent.c                        |    8 +++---
 include/asm-i386/system.h                  |    2 -
 include/asm-m32r/system.h                  |    2 -
 include/linux/sunrpc/gss_api.h             |    2 -
 lib/kernel_lock.c                          |    4 +--
 lib/zlib_inflate/inftrees.c                |    9 ------
 mm/page_alloc.c                            |    2 -
 mm/readahead.c                             |    4 +--
 net/sunrpc/auth_gss/gss_krb5_mech.c        |    2 -
 net/sunrpc/auth_gss/gss_spkm3_mech.c       |    2 -
 sound/core/seq/seq_memory.h                |    2 -
 sound/oss/sb_ess.c                         |   28 ++++++++++-----------
 sound/pci/cs5535audio/cs5535audio_pcm.c    |    2 -
 89 files changed, 147 insertions(+), 158 deletions(-)


diff --git a/CREDITS b/CREDITS
index 1d35f10..85c7c70 100644
--- a/CREDITS
+++ b/CREDITS
@@ -24,6 +24,11 @@ S: C. Negri 6, bl. D3
 S: Iasi 6600
 S: Romania
 
+N: Mark Adler
+E: madler@alumni.caltech.edu
+W: http://alumnus.caltech.edu/~madler/
+D: zlib decompression
+
 N: Monalisa Agrawal
 E: magrawal@nortelnetworks.com
 D: Basic Interphase 5575 driver with UBR and ABR support.
diff --git a/Documentation/DocBook/kernel-locking.tmpl b/Documentation/DocBook/kernel-locking.tmpl
index 158ffe9..644c388 100644
--- a/Documentation/DocBook/kernel-locking.tmpl
+++ b/Documentation/DocBook/kernel-locking.tmpl
@@ -1590,7 +1590,7 @@ the amount of locking which needs to be 
     <para>
       Our final dilemma is this: when can we actually destroy the
       removed element?  Remember, a reader might be stepping through
-      this element in the list right now: it we free this element and
+      this element in the list right now: if we free this element and
       the <symbol>next</symbol> pointer changes, the reader will jump
       off into garbage and crash.  We need to wait until we know that
       all the readers who were traversing the list when we deleted the
diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
index 23a1c24..2a63d56 100644
--- a/Documentation/atomic_ops.txt
+++ b/Documentation/atomic_ops.txt
@@ -157,13 +157,13 @@ For example, smp_mb__before_atomic_dec()
 	smp_mb__before_atomic_dec();
 	atomic_dec(&obj->ref_count);
 
-It makes sure that all memory operations preceeding the atomic_dec()
+It makes sure that all memory operations preceding the atomic_dec()
 call are strongly ordered with respect to the atomic counter
-operation.  In the above example, it guarentees that the assignment of
+operation.  In the above example, it guarantees that the assignment of
 "1" to obj->dead will be globally visible to other cpus before the
 atomic counter decrement.
 
-Without the explicitl smp_mb__before_atomic_dec() call, the
+Without the explicit smp_mb__before_atomic_dec() call, the
 implementation could legally allow the atomic counter update visible
 to other cpus before the "obj->dead = 1;" assignment.
 
@@ -173,11 +173,11 @@ (smp_mb__after_atomic_dec()) and around 
 (smp_mb__{before,after}_atomic_inc()).
 
 A missing memory barrier in the cases where they are required by the
-atomic_t implementation above can have disasterous results.  Here is
-an example, which follows a pattern occuring frequently in the Linux
+atomic_t implementation above can have disastrous results.  Here is
+an example, which follows a pattern occurring frequently in the Linux
 kernel.  It is the use of atomic counters to implement reference
 counting, and it works such that once the counter falls to zero it can
-be guarenteed that no other entity can be accessing the object:
+be guaranteed that no other entity can be accessing the object:
 
 static void obj_list_add(struct obj *obj)
 {
@@ -291,9 +291,9 @@ to the size of an "unsigned long" C data
 size.  The endianness of the bits within each "unsigned long" are the
 native endianness of the cpu.
 
-	void set_bit(unsigned long nr, volatils unsigned long *addr);
-	void clear_bit(unsigned long nr, volatils unsigned long *addr);
-	void change_bit(unsigned long nr, volatils unsigned long *addr);
+	void set_bit(unsigned long nr, volatile unsigned long *addr);
+	void clear_bit(unsigned long nr, volatile unsigned long *addr);
+	void change_bit(unsigned long nr, volatile unsigned long *addr);
 
 These routines set, clear, and change, respectively, the bit number
 indicated by "nr" on the bit mask pointed to by "ADDR".
@@ -301,9 +301,9 @@ indicated by "nr" on the bit mask pointe
 They must execute atomically, yet there are no implicit memory barrier
 semantics required of these interfaces.
 
-	int test_and_set_bit(unsigned long nr, volatils unsigned long *addr);
-	int test_and_clear_bit(unsigned long nr, volatils unsigned long *addr);
-	int test_and_change_bit(unsigned long nr, volatils unsigned long *addr);
+	int test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
+	int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
+	int test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
 
 Like the above, except that these routines return a boolean which
 indicates whether the changed bit was set _BEFORE_ the atomic bit
@@ -335,7 +335,7 @@ subsequent memory operation is made visi
 		/* ... */;
 	obj->killed = 1;
 
-The implementation of test_and_set_bit() must guarentee that
+The implementation of test_and_set_bit() must guarantee that
 "obj->dead = 1;" is visible to cpus before the atomic memory operation
 done by test_and_set_bit() becomes visible.  Likewise, the atomic
 memory operation done by test_and_set_bit() must become visible before
@@ -474,7 +474,7 @@ Now, as far as memory barriers go, as lo
 strictly orders all subsequent memory operations (including
 the cas()) with respect to itself, things will be fine.
 
-Said another way, _atomic_dec_and_lock() must guarentee that
+Said another way, _atomic_dec_and_lock() must guarantee that
 a counter dropping to zero is never made visible before the
 spinlock being acquired.
 
diff --git a/Documentation/driver-model/overview.txt b/Documentation/driver-model/overview.txt
index ac4a7a7..2050c9f 100644
--- a/Documentation/driver-model/overview.txt
+++ b/Documentation/driver-model/overview.txt
@@ -18,7 +18,7 @@ Traditional driver models implemented so
 (sometimes just a list) for the devices they control. There wasn't any
 uniformity across the different bus types.
 
-The current driver model provides a comon, uniform data model for describing
+The current driver model provides a common, uniform data model for describing
 a bus and the devices that can appear under the bus. The unified bus
 model includes a set of common attributes which all busses carry, and a set
 of common callbacks, such as device discovery during bus probing, bus
diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/kdump/gdbmacros.txt
index dcf5580..9b9b454 100644
--- a/Documentation/kdump/gdbmacros.txt
+++ b/Documentation/kdump/gdbmacros.txt
@@ -175,7 +175,7 @@ end
 document trapinfo
 	Run info threads and lookup pid of thread #1
 	'trapinfo <pid>' will tell you by which trap & possibly
-	addresthe kernel paniced.
+	address the kernel panicked.
 end
 
 
diff --git a/Documentation/scsi/ppa.txt b/Documentation/scsi/ppa.txt
index 0dac88d..5d9223b 100644
--- a/Documentation/scsi/ppa.txt
+++ b/Documentation/scsi/ppa.txt
@@ -12,5 +12,3 @@ http://www.torque.net/parport/
 Email list for Linux Parport
 linux-parport@torque.net
 
-Email for problems with ZIP or ZIP Plus drivers
-campbell@torque.net
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 1596101..e14b207 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -721,7 +721,7 @@ config KEXEC
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
+	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
 	  The name comes from the similiarity to the exec system call.
diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
index eb13048..21c9a4e 100644
--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -41,7 +41,7 @@ config M386
 	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
 	  - "Geode GX/LX" For AMD Geode GX and LX processors.
 	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
-	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
+	  - "VIA C3-2" for VIA C3-2 "Nehemiah" (model 9 and above).
 
 	  If you don't know what to do, choose "386".
 
diff --git a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
index fc32c80..f03b7f9 100644
--- a/arch/i386/kernel/cpu/cyrix.c
+++ b/arch/i386/kernel/cpu/cyrix.c
@@ -354,7 +354,7 @@ static void __init init_nsc(struct cpuin
 	 * This function only handles the GX processor, and kicks every
 	 * thing else to the Cyrix init function above - that should
 	 * cover any processors that might have been branded differently
-	 * after NSC aquired Cyrix.
+	 * after NSC acquired Cyrix.
 	 *
 	 * If this breaks your GX1 horribly, please e-mail
 	 * info-linux@ldcmail.amd.com to tell us.
diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
index 21dc1bb..13288d9 100644
--- a/arch/i386/kernel/crash.c
+++ b/arch/i386/kernel/crash.c
@@ -163,7 +163,7 @@ #endif
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* This function is only called after the system
-	 * has paniced or is otherwise in a critical state.
+	 * has panicked or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
 	 *
diff --git a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
index b7636b9..c1a42fe 100644
--- a/arch/i386/kernel/i8259.c
+++ b/arch/i386/kernel/i8259.c
@@ -175,7 +175,7 @@ static void mask_and_ack_8259A(unsigned 
 	 * Lightweight spurious IRQ detection. We do not want
 	 * to overdo spurious IRQ handling - it's usually a sign
 	 * of hardware problems, so we only do the checks we can
-	 * do without slowing down good hardware unnecesserily.
+	 * do without slowing down good hardware unnecessarily.
 	 *
 	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
 	 * usually resulting from the 8259A-1|2 PICs) occur
diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index f73d737..511abe5 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -133,9 +133,9 @@ typedef asmlinkage NORET_TYPE void (*rel
 					unsigned long start_address,
 					unsigned int has_pae) ATTRIB_NORET;
 
-const extern unsigned char relocate_new_kernel[];
+extern const unsigned char relocate_new_kernel[];
 extern void relocate_new_kernel_end(void);
-const extern unsigned int relocate_new_kernel_size;
+extern const unsigned int relocate_new_kernel_size;
 
 /*
  * A architecture hook called to validate the
diff --git a/arch/mips/momentum/ocelot_g/gt-irq.c b/arch/mips/momentum/ocelot_g/gt-irq.c
index e5eceed..8bd9b84 100644
--- a/arch/mips/momentum/ocelot_g/gt-irq.c
+++ b/arch/mips/momentum/ocelot_g/gt-irq.c
@@ -59,7 +59,7 @@ void hook_irq_handler(int int_cause, int
  * bit_num   - Indicates which bit number in the cause register
  *
  * Outputs :
- * 1 if succesful, 0 if failure
+ * 1 if successful, 0 if failure
  */
 int enable_galileo_irq(int int_cause, int bit_num)
 {
@@ -83,7 +83,7 @@ int enable_galileo_irq(int int_cause, in
  * bit_num   - Indicates which bit number in the cause register
  *
  * Outputs :
- * 1 if succesful, 0 if failure
+ * 1 if successful, 0 if failure
  */
 int disable_galileo_irq(int int_cause, int bit_num)
 {
diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index a9c58e0..8134220 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -34,7 +34,7 @@ #include <asm/sgi/ip22.h>
 #define POWERDOWN_TIMEOUT	120
 
 /*
- * Blink frequency during reboot grace period and when paniced.
+ * Blink frequency during reboot grace period and when panicked.
  */
 #define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index ab9d9ce..79ddb46 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -28,13 +28,13 @@ #include <asm/ip32/ip32_ints.h>
 
 #define POWERDOWN_TIMEOUT	120
 /*
- * Blink frequency during reboot grace period and when paniced.
+ * Blink frequency during reboot grace period and when panicked.
  */
 #define POWERDOWN_FREQ		(HZ / 4)
 #define PANIC_FREQ		(HZ / 8)
 
 static struct timer_list power_timer, blink_timer, debounce_timer;
-static int has_paniced, shuting_down;
+static int has_panicked, shuting_down;
 
 static void ip32_machine_restart(char *command) __attribute__((noreturn));
 static void ip32_machine_halt(void) __attribute__((noreturn));
@@ -109,7 +109,7 @@ static void debounce(unsigned long data)
 	}
 	CMOS_WRITE(reg_a & ~DS_REGA_DV0, RTC_REG_A);
 
-	if (has_paniced)
+	if (has_panicked)
 		ip32_machine_restart(NULL);
 
 	enable_irq(MACEISA_RTC_IRQ);
@@ -117,7 +117,7 @@ static void debounce(unsigned long data)
 
 static inline void ip32_power_button(void)
 {
-	if (has_paniced)
+	if (has_panicked)
 		return;
 
 	if (shuting_down || kill_proc(1, SIGINT, 1)) {
@@ -161,9 +161,9 @@ static int panic_event(struct notifier_b
 {
 	unsigned long led;
 
-	if (has_paniced)
+	if (has_panicked)
 		return NOTIFY_DONE;
-	has_paniced = 1;
+	has_panicked = 1;
 
 	/* turn off the green LED */
 	led = mace->perif.ctrl.misc | MACEISA_LED_GREEN;
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index dbcb859..e253a45 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -179,7 +179,7 @@ void default_machine_crash_shutdown(stru
 
 	/*
 	 * This function is only called after the system
-	 * has paniced or is otherwise in a critical state.
+	 * has panicked or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
 	 *
diff --git a/arch/powerpc/kernel/machine_kexec_32.c b/arch/powerpc/kernel/machine_kexec_32.c
index 4436061..cbaa341 100644
--- a/arch/powerpc/kernel/machine_kexec_32.c
+++ b/arch/powerpc/kernel/machine_kexec_32.c
@@ -30,8 +30,8 @@ typedef NORET_TYPE void (*relocate_new_k
  */
 void default_machine_kexec(struct kimage *image)
 {
-	const extern unsigned char relocate_new_kernel[];
-	const extern unsigned int relocate_new_kernel_size;
+	extern const unsigned char relocate_new_kernel[];
+	extern const unsigned int relocate_new_kernel_size;
 	unsigned long page_list;
 	unsigned long reboot_code_buffer, reboot_code_buffer_phys;
 	relocate_new_kernel_t rnk;
diff --git a/arch/powerpc/platforms/cell/spufs/switch.c b/arch/powerpc/platforms/cell/spufs/switch.c
index b30e55d..3068b42 100644
--- a/arch/powerpc/platforms/cell/spufs/switch.c
+++ b/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2100,7 +2100,7 @@ EXPORT_SYMBOL_GPL(spu_save);
  * @spu: pointer to SPU iomem structure.
  *
  * Perform harvest + restore, as we may not be coming
- * from a previous succesful save operation, and the
+ * from a previous successful save operation, and the
  * hardware state is unknown.
  */
 int spu_restore(struct spu_state *new, struct spu *spu)
diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index 98c23ae..c37a849 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -287,7 +287,7 @@ void pci_addr_cache_remove_device(struct
  * find the pci device that corresponds to a given address.
  * This routine scans all pci busses to build the cache.
  * Must be run late in boot process, after the pci controllers
- * have been scaned for devices (after all device resources are known).
+ * have been scanned for devices (after all device resources are known).
  */
 void __init pci_addr_cache_build(void)
 {
diff --git a/arch/ppc/kernel/machine_kexec.c b/arch/ppc/kernel/machine_kexec.c
index 84d65a8..a469ba4 100644
--- a/arch/ppc/kernel/machine_kexec.c
+++ b/arch/ppc/kernel/machine_kexec.c
@@ -25,8 +25,8 @@ typedef NORET_TYPE void (*relocate_new_k
 				unsigned long reboot_code_buffer,
 				unsigned long start_address) ATTRIB_NORET;
 
-const extern unsigned char relocate_new_kernel[];
-const extern unsigned int relocate_new_kernel_size;
+extern const unsigned char relocate_new_kernel[];
+extern const unsigned int relocate_new_kernel_size;
 
 void machine_shutdown(void)
 {
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index bad81b5..fbde6a9 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -27,8 +27,8 @@ static void kexec_halt_all_cpus(void *);
 
 typedef void (*relocate_kernel_t) (kimage_entry_t *, unsigned long);
 
-const extern unsigned char relocate_kernel[];
-const extern unsigned long long relocate_kernel_len;
+extern const unsigned char relocate_kernel[];
+extern const unsigned long long relocate_kernel_len;
 
 int
 machine_kexec_prepare(struct kimage *image)
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index dfe6f08..1f0439d 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -356,7 +356,7 @@ static void internal_add_vtimer(struct v
 
 	set_vtimer(event->expires);
 	spin_unlock_irqrestore(&vt_list->lock, flags);
-	/* release CPU aquired in prepare_vtimer or mod_virt_timer() */
+	/* release CPU acquired in prepare_vtimer or mod_virt_timer() */
 	put_cpu();
 }
 
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 4354652..6bcd8d9 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -25,8 +25,8 @@ typedef NORET_TYPE void (*relocate_new_k
 				unsigned long start_address,
 				unsigned long vbr_reg) ATTRIB_NORET;
 
-const extern unsigned char relocate_new_kernel[];
-const extern unsigned int relocate_new_kernel_size;
+extern const unsigned char relocate_new_kernel[];
+extern const unsigned int relocate_new_kernel_size;
 extern void *gdb_vbr_vector;
 
 /*
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0897852..290cec6 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1222,7 +1222,7 @@ int open_ubd_file(char *file, struct ope
 		}
 	}
 
-	/* Succesful return case! */
+	/* Successful return case! */
 	if(backing_file_out == NULL)
 		return(fd);
 
diff --git a/arch/x86_64/kernel/crash.c b/arch/x86_64/kernel/crash.c
index 4e6c3b7..15beddc 100644
--- a/arch/x86_64/kernel/crash.c
+++ b/arch/x86_64/kernel/crash.c
@@ -161,7 +161,7 @@ void machine_crash_shutdown(struct pt_re
 {
 	/*
 	 * This function is only called after the system
-	 * has paniced or is otherwise in a critical state.
+	 * has panicked or is otherwise in a critical state.
 	 * The minimum amount of code to allow a kexec'd kernel
 	 * to run successfully needs to happen here.
 	 *
diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
index 5ecd34a..573990a 100644
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -278,7 +278,7 @@ static void mask_and_ack_8259A(unsigned 
 	 * Lightweight spurious IRQ detection. We do not want
 	 * to overdo spurious IRQ handling - it's usually a sign
 	 * of hardware problems, so we only do the checks we can
-	 * do without slowing down good hardware unnecesserily.
+	 * do without slowing down good hardware unnecessarily.
 	 *
 	 * Note that IRQ7 and IRQ15 (the two spurious IRQs
 	 * usually resulting from the 8259A-1|2 PICs) occur
diff --git a/arch/x86_64/kernel/machine_kexec.c b/arch/x86_64/kernel/machine_kexec.c
index 25ac8a3..83fb24a 100644
--- a/arch/x86_64/kernel/machine_kexec.c
+++ b/arch/x86_64/kernel/machine_kexec.c
@@ -149,8 +149,8 @@ typedef NORET_TYPE void (*relocate_new_k
 					unsigned long start_address,
 					unsigned long pgtable) ATTRIB_NORET;
 
-const extern unsigned char relocate_new_kernel[];
-const extern unsigned long relocate_new_kernel_size;
+extern const unsigned char relocate_new_kernel[];
+extern const unsigned long relocate_new_kernel_size;
 
 int machine_kexec_prepare(struct kimage *image)
 {
diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
index 4a6628b..e369a34 100644
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -470,7 +470,7 @@ void smp_send_stop(void)
 		return;
 	/* Don't deadlock on the call lock in panic */
 	if (!spin_trylock(&call_lock)) {
-		/* ignore locking because we have paniced anyways */
+		/* ignore locking because we have panicked anyways */
 		nolock = 1;
 	}
 	__smp_call_function(smp_really_stop_cpu, NULL, 0, 0);
diff --git a/block/as-iosched.c b/block/as-iosched.c
index 1ec5df4..3af31ed 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -892,7 +892,7 @@ static int as_can_break_anticipation(str
 }
 
 /*
- * as_can_anticipate indicates weather we should either run arq
+ * as_can_anticipate indicates whether we should either run arq
  * or keep anticipating a better request.
  */
 static int as_can_anticipate(struct as_data *ad, struct as_rq *arq)
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 0603ab2..c04422a 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2745,7 +2745,7 @@ static int attempt_merge(request_queue_t
 		return 0;
 
 	/*
-	 * not contigious
+	 * not contiguous
 	 */
 	if (req->sector + req->nr_sectors != next->sector)
 		return 0;
@@ -3415,7 +3415,7 @@ #endif /* CONFIG_HOTPLUG_CPU */
  *
  * Description:
  *     Ends all I/O on a request. It does not handle partial completions,
- *     unless the driver actually implements this in its completionc callback
+ *     unless the driver actually implements this in its completion callback
  *     through requeueing. Theh actual completion happens out-of-order,
  *     through a softirq handler. The user must have registered a completion
  *     callback through blk_queue_softirq_done().
diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 7f7ec28..f2eeaf9 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -951,7 +951,7 @@ static int fs_open(struct atm_vcc *atm_v
 		   it most likely that the chip will notice it. It also prevents us
 		   from having to wait for completion. On the other hand, we may
 		   need to wait for completion anyway, to see if it completed
-		   succesfully. */
+		   successfully. */
 
 		switch (atm_vcc->qos.aal) {
 		case ATM_AAL2:
diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 1f77665..51d0d56 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -118,7 +118,7 @@ static int amd_create_gatt_pages(int nr_
 	return retval;
 }
 
-/* Since we don't need contigious memory we just try
+/* Since we don't need contiguous memory we just try
  * to get the gatt table once
  */
 
diff --git a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
index 06fd10b..1605643 100644
--- a/drivers/char/agp/ati-agp.c
+++ b/drivers/char/agp/ati-agp.c
@@ -261,7 +261,7 @@ static int agp_ati_suspend(struct pci_de
 #endif
 
 /*
- *Since we don't need contigious memory we just try
+ *Since we don't need contiguous memory we just try
  * to get the gatt table once
  */
 
diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index 86a966b..b788b0a 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -177,7 +177,7 @@ static int efficeon_free_gatt_table(stru
 
 
 /*
- * Since we don't need contigious memory we just try
+ * Since we don't need contiguous memory we just try
  * to get the gatt table once
  */
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 9f2f8fd..586f1f8 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3677,7 +3677,7 @@ #endif /* CONFIG_IPMI_PANIC_STRING */
 }
 #endif /* CONFIG_IPMI_PANIC_EVENT */
 
-static int has_paniced = 0;
+static int has_panicked = 0;
 
 static int panic_event(struct notifier_block *this,
 		       unsigned long         event,
@@ -3686,9 +3686,9 @@ static int panic_event(struct notifier_b
 	int        i;
 	ipmi_smi_t intf;
 
-	if (has_paniced)
+	if (has_panicked)
 		return NOTIFY_DONE;
-	has_paniced = 1;
+	has_panicked = 1;
 
 	/* For every registered interface, set it to run to completion. */
 	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
diff --git a/drivers/char/rio/riointr.c b/drivers/char/rio/riointr.c
index eec1fea..0bd0904 100644
--- a/drivers/char/rio/riointr.c
+++ b/drivers/char/rio/riointr.c
@@ -546,7 +546,7 @@ static void RIOReceive(struct rio_info *
 	 ** run out of space it will be set to the offset of the
 	 ** next byte to copy from the packet data area. The packet
 	 ** length field is decremented by the number of bytes that
-	 ** we succesfully removed from the packet. When this reaches
+	 ** we successfully removed from the packet. When this reaches
 	 ** zero, we reset the offset pointer to be zero, and free
 	 ** the packet from the front of the queue.
 	 */
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 65b2709..facc1cc 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -341,7 +341,7 @@ static ssize_t set_fan_min(struct device
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 				size_t count, int nr)
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 94be3d7..a6ce7ab 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -358,7 +358,7 @@ static ssize_t show_fan_div(struct devic
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index f72120d..b4ccdfc 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -253,7 +253,7 @@ set_fan(min2, fan_min[1], LM80_REG_FAN_M
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index e229daf..e6c1b63 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -421,7 +421,7 @@ static void set_fan_min(struct device *d
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan clock divider.  This follows the principle
-   of least suprise; the user doesn't expect the fan minimum to change just
+   of least surprise; the user doesn't expect the fan minimum to change just
    because the divider changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 6f3fda7..063f71c 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -380,7 +380,7 @@ static ssize_t show_fan_div(struct devic
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 	size_t count, int nr)
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 7732aec..825e8f7 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -207,7 +207,7 @@ static ssize_t set_fan_min(struct device
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan clock divider.  This follows the principle
-   of least suprise; the user doesn't expect the fan minimum to change just
+   of least surprise; the user doesn't expect the fan minimum to change just
    because the divider changed. */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 71fb7f1..79368d5 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -781,7 +781,7 @@ show_fan_div_reg(struct device *dev, cha
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index e4c7003..7be469e 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -630,7 +630,7 @@ show_fan_div_reg(struct device *dev, cha
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
 store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 4ef884c..e407c74 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -463,7 +463,7 @@ show_fan_div(struct device *dev, struct 
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
-   least suprise; the user doesn't expect the fan minimum to change just
+   least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
 store_fan_div(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index a5017de..f033d73 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -37,7 +37,7 @@
  * Version 1.15		convert all calls to ide_raw_taskfile
  *				since args will return register content.
  * Version 1.16		added suspend-resume-checkpower
- * Version 1.17		do flush on standy, do flush on ATA < ATA6
+ * Version 1.17		do flush on standby, do flush on ATA < ATA6
  *			fix wcache setup.
  */
 
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 622a55c..05ba8e0 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1665,7 +1665,7 @@ #endif /* CONFIG_BLK_DEV_IDEPCI */
  *	Initialize a request before we fill it in and send it down to
  *	ide_do_drive_cmd. Commands must be set up by this function. Right
  *	now it doesn't do a lot, but if that changes abusers will have a
- *	nasty suprise.
+ *	nasty surprise.
  */
 
 void ide_init_drive_cmd (struct request *rq)
diff --git a/drivers/ieee1394/hosts.c b/drivers/ieee1394/hosts.c
index 2d47b11..ad49c04 100644
--- a/drivers/ieee1394/hosts.c
+++ b/drivers/ieee1394/hosts.c
@@ -103,7 +103,7 @@ static int alloc_hostnum_cb(struct hpsb_
  * driver specific parts, enable the controller and make it available
  * to the general subsystem using hpsb_add_host().
  *
- * Return Value: a pointer to the &hpsb_host if succesful, %NULL if
+ * Return Value: a pointer to the &hpsb_host if successful, %NULL if
  * no memory was available.
  */
 static DEFINE_MUTEX(host_num_alloc);
diff --git a/drivers/ieee1394/ieee1394_core.h b/drivers/ieee1394/ieee1394_core.h
index e7b55e8..0ecbf33 100644
--- a/drivers/ieee1394/ieee1394_core.h
+++ b/drivers/ieee1394/ieee1394_core.h
@@ -139,7 +139,7 @@ int hpsb_bus_reset(struct hpsb_host *hos
 
 /*
  * Hand over received selfid packet to the core.  Complement check (second
- * quadlet is complement of first) is expected to be done and succesful.
+ * quadlet is complement of first) is expected to be done and successful.
  */
 void hpsb_selfid_received(struct hpsb_host *host, quadlet_t sid);
 
diff --git a/drivers/isdn/divert/isdn_divert.c b/drivers/isdn/divert/isdn_divert.c
index f1a1f9a..1f5ebe9 100644
--- a/drivers/isdn/divert/isdn_divert.c
+++ b/drivers/isdn/divert/isdn_divert.c
@@ -592,7 +592,7 @@ static int put_address(char *st, u_char 
 } /* put_address */
 
 /*************************************/
-/* report a succesfull interrogation */
+/* report a successful interrogation */
 /*************************************/
 static int interrogate_success(isdn_ctrl *ic, struct call_struc *cs)
 { char *src = ic->parm.dss1_io.data;
diff --git a/drivers/media/video/bt8xx/bttv-cards.c b/drivers/media/video/bt8xx/bttv-cards.c
index 3116345..e68a6d2 100644
--- a/drivers/media/video/bt8xx/bttv-cards.c
+++ b/drivers/media/video/bt8xx/bttv-cards.c
@@ -4848,7 +4848,7 @@ static void picolo_tetra_muxsel (struct 
  *
  * The IVC120G security card has 4 i2c controlled TDA8540 matrix
  * swichers to provide 16 channels to MUX0. The TDA8540's have
- * 4 indepedant outputs and as such the IVC120G also has the
+ * 4 independent outputs and as such the IVC120G also has the
  * optional "Monitor Out" bus. This allows the card to be looking
  * at one input while the monitor is looking at another.
  *
diff --git a/drivers/net/3c501.c b/drivers/net/3c501.c
index bb44509..07136ec 100644
--- a/drivers/net/3c501.c
+++ b/drivers/net/3c501.c
@@ -508,11 +508,11 @@ static int el_start_xmit(struct sk_buff 
  * speak of. We simply pull the packet out of its PIO buffer (which is slow)
  * and queue it for the kernel. Then we reset the card for the next packet.
  *
- * We sometimes get suprise interrupts late both because the SMP IRQ delivery
+ * We sometimes get surprise interrupts late both because the SMP IRQ delivery
  * is message passing and because the card sometimes seems to deliver late. I
  * think if it is part way through a receive and the mode is changed it carries
  * on receiving and sends us an interrupt. We have to band aid all these cases
- * to get a sensible 150kbytes/second performance. Even then you want a small
+ * to get a sensible 150kBytes/second performance. Even then you want a small
  * TCP window.
  */
 
diff --git a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
index 98fa531..44efd49 100644
--- a/drivers/net/irda/irport.c
+++ b/drivers/net/irda/irport.c
@@ -386,7 +386,7 @@ static int __irport_change_speed(struct 
 	/* Locking notes : this function may be called from irq context with
 	 * spinlock, via irport_write_wakeup(), or from non-interrupt without
 	 * spinlock (from the task timer). Yuck !
-	 * This is ugly, and unsafe is the spinlock is not already aquired.
+	 * This is ugly, and unsafe is the spinlock is not already acquired.
 	 * This will be fixed when irda-task get rewritten.
 	 * Jean II */
 	if (!spin_is_locked(&self->lock)) {
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
index e74bf50..a73d545 100644
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -1883,7 +1883,7 @@ static void smc_reset(struct net_device 
     /* Set the Window 1 control, configuration and station addr registers.
        No point in writing the I/O base register ;-> */
     SMC_SELECT_BANK(1);
-    /* Automatically release succesfully transmitted packets,
+    /* Automatically release successfully transmitted packets,
        Accept link errors, counter and Tx error interrupts. */
     outw(CTL_AUTO_RELEASE | CTL_TE_ENABLE | CTL_CR_ENABLE,
 	 ioaddr + CONTROL);
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 72335c8..94aeb23 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -1485,7 +1485,7 @@ #define HW_POWER_DOWN_DELAY (msecs_to_ji
 		 *
 		 * Sending the PREPARE_FOR_POWER_DOWN will restrict the
 		 * hardware from going into standby mode and will transition
-		 * out of D0-standy if it is already in that state.
+		 * out of D0-standby if it is already in that state.
 		 *
 		 * STATUS_PREPARE_POWER_DOWN_COMPLETE will be sent by the
 		 * driver upon completion.  Once received, the driver can
diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 1de52d9..7352104 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -15,7 +15,7 @@
  * 	    Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
- *          David Campbell <campbell@torque.net>
+ *          David Campbell
  *          Andrea Arcangeli
  */
 
diff --git a/drivers/parport/parport_gsc.h b/drivers/parport/parport_gsc.h
index 662f6c1..fc9c37c 100644
--- a/drivers/parport/parport_gsc.h
+++ b/drivers/parport/parport_gsc.h
@@ -24,7 +24,7 @@
  * 	    Phil Blundell <Philip.Blundell@pobox.com>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
- *          David Campbell <campbell@torque.net>
+ *          David Campbell
  *          Andrea Arcangeli
  */
 
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 48bbf32..7318e4a 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -3,7 +3,7 @@
  * Authors: Phil Blundell <philb@gnu.org>
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *	    Jose Renau <renau@acm.org>
- *          David Campbell <campbell@torque.net>
+ *          David Campbell
  *          Andrea Arcangeli
  *
  * based on work by Grant Guenther <grant@torque.net> and Phil Blundell.
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index cbe1718..8610ae8 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -1,6 +1,6 @@
 /* Sysctl interface for parport devices.
  * 
- * Authors: David Campbell <campbell@torque.net>
+ * Authors: David Campbell
  *          Tim Waugh <tim@cyberelk.demon.co.uk>
  *          Philip Blundell <philb@gnu.org>
  *          Andrea Arcangeli
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d408a3c..23d3b17 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -369,7 +369,7 @@ pci_set_power_state(struct pci_dev *dev,
 
 	/*
 	 * Give firmware a chance to be called, such as ACPI _PRx, _PSx
-	 * Firmware method after natice method ?
+	 * Firmware method after native method ?
 	 */
 	if (platform_pci_set_power_state)
 		platform_pci_set_power_state(dev, state);
diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 4682c8b..909731b 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -167,7 +167,7 @@ zfcp_fsf_scsi_er_timeout_handler(unsigne
  *		initiates adapter recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
@@ -203,7 +203,7 @@ zfcp_erp_adapter_reopen_internal(struct 
  * purpose:	Wrappper for zfcp_erp_adapter_reopen_internal
  *              used to ensure the correct locking
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
@@ -469,7 +469,7 @@ zfcp_test_link(struct zfcp_port *port)
  *		initiates Forced Reopen recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 static int
@@ -509,7 +509,7 @@ zfcp_erp_port_forced_reopen_internal(str
  * purpose:	Wrappper for zfcp_erp_port_forced_reopen_internal
  *              used to ensure the correct locking
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
@@ -536,7 +536,7 @@ zfcp_erp_port_forced_reopen(struct zfcp_
  *		initiates Reopen recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 static int
@@ -605,7 +605,7 @@ zfcp_erp_port_reopen(struct zfcp_port *p
  *		initiates Reopen recovery which is done
  *		asynchronously
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 static int
@@ -1805,7 +1805,7 @@ zfcp_erp_modify_unit_status(struct zfcp_
  * purpose:	Wrappper for zfcp_erp_port_reopen_all_internal
  *              used to ensure the correct locking
  *
- * returns:	0	- initiated action succesfully
+ * returns:	0	- initiated action successfully
  *		<0	- failed to initiate action
  */
 int
diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index fa57e0b..75f2f7a 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -500,7 +500,7 @@ #endif
 /* 
  * Function : int should_disconnect (unsigned char cmd)
  *
- * Purpose : decide weather a command would normally disconnect or 
+ * Purpose : decide whether a command would normally disconnect or 
  *      not, since if it won't disconnect we should go to sleep.
  *
  * Input : cmd - opcode of SCSI command
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 5ee4755..dd9fb3d 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -12374,7 +12374,7 @@ AscInitFromEEP(ASC_DVC_VAR *asc_dvc)
                 ASC_PRINT1(
 "AscInitFromEEP: Failed to re-write EEPROM with %d errors.\n", i);
         } else {
-                ASC_PRINT("AscInitFromEEP: Succesfully re-wrote EEPROM.");
+                ASC_PRINT("AscInitFromEEP: Successfully re-wrote EEPROM.\n");
         }
     }
     return (warn_code);
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 1832452..58b0748 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -3771,7 +3771,7 @@ static void request_sense(struct Adapter
  * @target: The target for the new device.
  * @lun: The lun for the new device.
  *
- * Return the new device if succesfull or NULL on failure.
+ * Return the new device if successful or NULL on failure.
  **/
 static struct DeviceCtlBlk *device_alloc(struct AdapterCtlBlk *acb,
 		u8 target, u8 lun)
diff --git a/drivers/scsi/ibmmca.c b/drivers/scsi/ibmmca.c
index 115f554..497f664 100644
--- a/drivers/scsi/ibmmca.c
+++ b/drivers/scsi/ibmmca.c
@@ -760,7 +760,7 @@ static int device_inquiry(int host_index
 		while (!got_interrupt(host_index))
 			barrier();
 
-		/*if command succesful, break */
+		/*if command successful, break */
 		if ((stat_result(host_index) == IM_SCB_CMD_COMPLETED) || (stat_result(host_index) == IM_SCB_CMD_COMPLETED_WITH_RETRIES))
 			return 1;
 	}
@@ -885,7 +885,7 @@ static int immediate_assign(int host_ind
 		while (!got_interrupt(host_index))
 			barrier();
 
-		/*if command succesful, break */
+		/*if command successful, break */
 		if (stat_result(host_index) == IM_IMMEDIATE_CMD_COMPLETED)
 			return 1;
 	}
@@ -921,7 +921,7 @@ static int immediate_feature(int host_in
 			return 2;
 		} else
 			global_command_error_excuse = 0;
-		/*if command succesful, break */
+		/*if command successful, break */
 		if (stat_result(host_index) == IM_IMMEDIATE_CMD_COMPLETED)
 			return 1;
 	}
@@ -959,7 +959,7 @@ static int immediate_reset(int host_inde
 			/* did not work, finish */
 			return 1;
 		}
-		/*if command succesful, break */
+		/*if command successful, break */
 		if (stat_result(host_index) == IM_IMMEDIATE_CMD_COMPLETED)
 			return 1;
 	}
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index cd2dffd..681bd18 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -3,9 +3,6 @@
  * 
  * (The IMM is the embedded controller in the ZIP Plus drive.)
  * 
- * Current Maintainer: David Campbell (Perth, Western Australia)
- *                     campbell@torque.net
- *
  * My unoffical company acronym list is 21 pages long:
  *      FLA:    Four letter acronym with built in facility for
  *              future expansion to five letters.
diff --git a/drivers/scsi/imm.h b/drivers/scsi/imm.h
index dc3aebf..ece936a 100644
--- a/drivers/scsi/imm.h
+++ b/drivers/scsi/imm.h
@@ -2,7 +2,7 @@
 /*  Driver for the Iomega MatchMaker parallel port SCSI HBA embedded in 
  * the Iomega ZIP Plus drive
  * 
- * (c) 1998     David Campbell     campbell@torque.net
+ * (c) 1998     David Campbell
  *
  * Please note that I live in Perth, Western Australia. GMT+0800
  */
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 5353b28..78f2ff7 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -6438,7 +6438,7 @@ ips_erase_bios(ips_ha_t * ha)
 		/* VPP failure */
 		return (1);
 
-	/* check for succesful flash */
+	/* check for successful flash */
 	if (status & 0x30)
 		/* sequence error */
 		return (1);
@@ -6550,7 +6550,7 @@ ips_erase_bios_memio(ips_ha_t * ha)
 		/* VPP failure */
 		return (1);
 
-	/* check for succesful flash */
+	/* check for successful flash */
 	if (status & 0x30)
 		/* sequence error */
 		return (1);
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 108910f..d58ac5a 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -6,8 +6,6 @@
  * (c) 1995,1996 Grant R. Guenther, grant@torque.net,
  * under the terms of the GNU General Public License.
  * 
- * Current Maintainer: David Campbell (Perth, Western Australia, GMT+0800)
- *                     campbell@torque.net
  */
 
 #include <linux/config.h>
diff --git a/drivers/scsi/ppa.h b/drivers/scsi/ppa.h
index f6e1a15..7511df3 100644
--- a/drivers/scsi/ppa.h
+++ b/drivers/scsi/ppa.h
@@ -2,7 +2,7 @@
  * the Iomega ZIP drive
  * 
  * (c) 1996     Grant R. Guenther  grant@torque.net
- *              David Campbell     campbell@torque.net
+ *              David Campbell
  *
  *      All comments to David.
  */
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 1272dd2..b5218fc 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -2818,7 +2818,7 @@ static int st_int_ioctl(struct scsi_tape
 		    (cmdstatp->sense_hdr.sense_key == NO_SENSE ||
 		     cmdstatp->sense_hdr.sense_key == RECOVERED_ERROR) &&
 		    undone == 0) {
-			ioctl_result = 0;	/* EOF written succesfully at EOM */
+			ioctl_result = 0;	/* EOF written successfully at EOM */
 			if (fileno >= 0)
 				fileno++;
 			STps->drv_file = fileno;
diff --git a/drivers/telephony/ixj.c b/drivers/telephony/ixj.c
index 5578a9d..f6b2948 100644
--- a/drivers/telephony/ixj.c
+++ b/drivers/telephony/ixj.c
@@ -5712,7 +5712,7 @@ static int ixj_daa_write(IXJ *j)
 	return 1;
 }
 
-int ixj_set_tone_off(unsigned short arg, IXJ *j)
+static int ixj_set_tone_off(unsigned short arg, IXJ *j)
 {
 	j->tone_off_time = arg;
 	if (ixj_WriteDSPCommand(0x6E05, j))		/* Set Tone Off Period */
diff --git a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
index 009fb09..5284abe 100644
--- a/drivers/usb/storage/usb.h
+++ b/drivers/usb/storage/usb.h
@@ -160,10 +160,10 @@ #endif
 };
 
 /* Convert between us_data and the corresponding Scsi_Host */
-static struct Scsi_Host inline *us_to_host(struct us_data *us) {
+static inline struct Scsi_Host *us_to_host(struct us_data *us) {
 	return container_of((void *) us, struct Scsi_Host, hostdata);
 }
-static struct us_data inline *host_to_us(struct Scsi_Host *host) {
+static inline struct us_data *host_to_us(struct Scsi_Host *host) {
 	return (struct us_data *) host->hostdata;
 }
 
diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index f4407eb..12e1baa 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -712,7 +712,7 @@ static void v9fs_read_work(void *a)
  * v9fs_send_request - send 9P request
  * The function can sleep until the request is scheduled for sending.
  * The function can be interrupted. Return from the function is not
- * a guarantee that the request is sent succesfully. Can return errors
+ * a guarantee that the request is sent successfully. Can return errors
  * that can be retrieved by PTR_ERR macros.
  *
  * @m: mux data
diff --git a/fs/aio.c b/fs/aio.c
index 8c34a62..9506301 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -641,7 +641,7 @@ static inline int __queue_kicked_iocb(st
  *	invoked both for initial i/o submission and
  *	subsequent retries via the aio_kick_handler.
  *	Expects to be invoked with iocb->ki_ctx->lock
- *	already held. The lock is released and reaquired
+ *	already held. The lock is released and reacquired
  *	as needed during processing.
  *
  * Calls the iocb retry method (already setup for the
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index 0b02fc7..be1acc3 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -43,7 +43,7 @@ int jffs2_sum_init(struct jffs2_sb_info 
 		return -ENOMEM;
 	}
 
-	dbg_summary("returned succesfully\n");
+	dbg_summary("returned successfully\n");
 
 	return 0;
 }
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 5549378..4d52593 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -126,7 +126,7 @@ extAlloc(struct inode *ip, s64 xlen, s64
 
 	/* allocate the disk blocks for the extent.  initially, extBalloc()
 	 * will try to allocate disk blocks for the requested size (xlen). 
-	 * if this fails (xlen contigious free blocks not avaliable), it'll
+	 * if this fails (xlen contiguous free blocks not avaliable), it'll
 	 * try to allocate a smaller number of blocks (producing a smaller
 	 * extent), with this smaller number of blocks consisting of the
 	 * requested number of blocks rounded down to the next smaller
@@ -493,7 +493,7 @@ #endif			/* _NOTYET */
  *
  *		initially, we will try to allocate disk blocks for the
  *		requested size (nblocks).  if this fails (nblocks 
- *		contigious free blocks not avaliable), we'll try to allocate
+ *		contiguous free blocks not avaliable), we'll try to allocate
  *		a smaller number of blocks (producing a smaller extent), with
  *		this smaller number of blocks consisting of the requested
  *		number of blocks rounded down to the next smaller power of 2
@@ -529,7 +529,7 @@ extBalloc(struct inode *ip, s64 hint, s6
 
 	/* get the number of blocks to initially attempt to allocate.
 	 * we'll first try the number of blocks requested unless this
-	 * number is greater than the maximum number of contigious free
+	 * number is greater than the maximum number of contiguous free
 	 * blocks in the map. in that case, we'll start off with the 
 	 * maximum free.
 	 */
@@ -586,7 +586,7 @@ #ifdef _NOTYET
  *		in place.  if this fails, we'll try to move the extent
  *		to a new set of blocks. if moving the extent, we initially
  *		will try to allocate disk blocks for the requested size
- *		(nnew).  if this fails 	(nnew contigious free blocks not
+ *		(nnew).  if this fails 	(new contiguous free blocks not
  *		avaliable), we'll try  to allocate a smaller number of
  *		blocks (producing a smaller extent), with this smaller
  *		number of blocks consisting of the requested number of
diff --git a/include/asm-i386/system.h b/include/asm-i386/system.h
index 0249f91..cab0180 100644
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -427,7 +427,7 @@ #define rmb() alternative("lock; addl $0
  * does not enforce ordering, since there is no data dependency between
  * the read of "a" and the read of "b".  Therefore, on some CPUs, such
  * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like thiswhere there are no data dependencies.
+ * in cases like this where there are no data dependencies.
  **/
 
 #define read_barrier_depends()	do { } while(0)
diff --git a/include/asm-m32r/system.h b/include/asm-m32r/system.h
index 33567e8..66c4742 100644
--- a/include/asm-m32r/system.h
+++ b/include/asm-m32r/system.h
@@ -318,7 +318,7 @@ #define wmb()  mb()
  * does not enforce ordering, since there is no data dependency between
  * the read of "a" and the read of "b".  Therefore, on some CPUs, such
  * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like thiswhere there are no data dependencies.
+ * in cases like this where there are no data dependencies.
  **/
 
 #define read_barrier_depends()	do { } while (0)
diff --git a/include/linux/sunrpc/gss_api.h b/include/linux/sunrpc/gss_api.h
index 9b8bcf1..6e112cc 100644
--- a/include/linux/sunrpc/gss_api.h
+++ b/include/linux/sunrpc/gss_api.h
@@ -126,7 +126,7 @@ struct gss_api_mech *gss_mech_get_by_pse
 /* Just increments the mechanism's reference count and returns its input: */
 struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
 
-/* For every succesful gss_mech_get or gss_mech_get_by_* call there must be a
+/* For every successful gss_mech_get or gss_mech_get_by_* call there must be a
  * corresponding call to gss_mech_put. */
 void gss_mech_put(struct gss_api_mech *);
 
diff --git a/lib/kernel_lock.c b/lib/kernel_lock.c
index cb5490e..e713e86 100644
--- a/lib/kernel_lock.c
+++ b/lib/kernel_lock.c
@@ -14,7 +14,7 @@ #ifdef CONFIG_PREEMPT_BKL
  * The 'big kernel semaphore'
  *
  * This mutex is taken and released recursively by lock_kernel()
- * and unlock_kernel().  It is transparently dropped and reaquired
+ * and unlock_kernel().  It is transparently dropped and reacquired
  * over schedule().  It is used to protect legacy code that hasn't
  * been migrated to a proper locking design yet.
  *
@@ -92,7 +92,7 @@ #else
  * The 'big kernel lock'
  *
  * This spinlock is taken and released recursively by lock_kernel()
- * and unlock_kernel().  It is transparently dropped and reaquired
+ * and unlock_kernel().  It is transparently dropped and reacquired
  * over schedule().  It is used to protect legacy code that hasn't
  * been migrated to a proper locking design yet.
  *
diff --git a/lib/zlib_inflate/inftrees.c b/lib/zlib_inflate/inftrees.c
index 62343c5..da665fb 100644
--- a/lib/zlib_inflate/inftrees.c
+++ b/lib/zlib_inflate/inftrees.c
@@ -8,15 +8,6 @@ #include "inftrees.h"
 
 #define MAXBITS 15
 
-const char inflate_copyright[] =
-   " inflate 1.2.3 Copyright 1995-2005 Mark Adler ";
-/*
-  If you use the zlib library in a product, an acknowledgment is welcome
-  in the documentation of your product. If for some reason you cannot
-  include such an acknowledgment, I would appreciate that you keep this
-  copyright string in the executable of your product.
- */
-
 /*
    Build a set of tables to decode the provided canonical Huffman code.
    The code lengths are lens[0..codes-1].  The result starts at *table,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6c1174f..9f86191 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -266,7 +266,7 @@ static inline void rmv_page_order(struct
  * satisfies the following equation:
  *     P = B & ~(1 << O)
  *
- * Assumption: *_mem_map is contigious at least up to MAX_ORDER
+ * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
  */
 static inline struct page *
 __page_find_buddy(struct page *page, unsigned long page_idx, unsigned int order)
diff --git a/mm/readahead.c b/mm/readahead.c
index e39e416..aa7ec42 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -390,8 +390,8 @@ int do_page_cache_readahead(struct addre
  * Read 'nr_to_read' pages starting at page 'offset'. If the flag 'block'
  * is set wait till the read completes.  Otherwise attempt to read without
  * blocking.
- * Returns 1 meaning 'success' if read is succesfull without switching off
- * readhaead mode. Otherwise return failure.
+ * Returns 1 meaning 'success' if read is successful without switching off
+ * readahead mode. Otherwise return failure.
  */
 static int
 blockable_page_cache_readahead(struct address_space *mapping, struct file *filp,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 129e2bd..b8714a8 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -169,7 +169,7 @@ gss_import_sec_context_kerberos(const vo
 	}
 
 	ctx_id->internal_ctx_id = ctx;
-	dprintk("RPC:      Succesfully imported new context.\n");
+	dprintk("RPC:      Successfully imported new context.\n");
 	return 0;
 
 out_err_free_key2:
diff --git a/net/sunrpc/auth_gss/gss_spkm3_mech.c b/net/sunrpc/auth_gss/gss_spkm3_mech.c
index 5bf11cc..3d0432a 100644
--- a/net/sunrpc/auth_gss/gss_spkm3_mech.c
+++ b/net/sunrpc/auth_gss/gss_spkm3_mech.c
@@ -201,7 +201,7 @@ gss_import_sec_context_spkm3(const void 
 
 	ctx_id->internal_ctx_id = ctx;
 
-	dprintk("Succesfully imported new spkm context.\n");
+	dprintk("Successfully imported new spkm context.\n");
 	return 0;
 
 out_err_free_key2:
diff --git a/sound/core/seq/seq_memory.h b/sound/core/seq/seq_memory.h
index 39c60d9..63e9143 100644
--- a/sound/core/seq/seq_memory.h
+++ b/sound/core/seq/seq_memory.h
@@ -31,7 +31,7 @@ struct snd_seq_event_cell {
 	struct snd_seq_event_cell *next;	/* next cell */
 };
 
-/* design note: the pool is a contigious block of memory, if we dynamicly
+/* design note: the pool is a contiguous block of memory, if we dynamicly
    want to add additional cells to the pool be better store this in another
    pool as we need to know the base address of the pool when releasing
    memory. */
diff --git a/sound/oss/sb_ess.c b/sound/oss/sb_ess.c
index fae05fe..180e95c 100644
--- a/sound/oss/sb_ess.c
+++ b/sound/oss/sb_ess.c
@@ -97,19 +97,19 @@ #undef FKS_TEST
  *
  * The documentation is an adventure: it's close but not fully accurate. I
  * found out that after a reset some registers are *NOT* reset, though the
- * docs say the would be. Interresting ones are 0x7f, 0x7d and 0x7a. They are
- * related to the Audio 2 channel. I also was suprised about the consequenses
+ * docs say the would be. Interesting ones are 0x7f, 0x7d and 0x7a. They are
+ * related to the Audio 2 channel. I also was surprised about the consequences
  * of writing 0x00 to 0x7f (which should be done by reset): The ES1887 moves
  * into ES1888 mode. This means that it claims IRQ 11, which happens to be my
  * ISDN adapter. Needless to say it no longer worked. I now understand why
  * after rebooting 0x7f already was 0x05, the value of my choice: the BIOS
  * did it.
  *
- * Oh, and this is another trap: in ES1887 docs mixer register 0x70 is decribed
- * as if it's exactly the same as register 0xa1. This is *NOT* true. The
- * description of 0x70 in ES1869 docs is accurate however.
+ * Oh, and this is another trap: in ES1887 docs mixer register 0x70 is
+ * described as if it's exactly the same as register 0xa1. This is *NOT* true.
+ * The description of 0x70 in ES1869 docs is accurate however.
  * Well, the assumption about ES1869 was wrong: register 0x70 is very much
- * like register 0xa1, except that bit 7 is allways 1, whatever you want
+ * like register 0xa1, except that bit 7 is always 1, whatever you want
  * it to be.
  *
  * When using audio 2 mixer register 0x72 seems te be meaningless. Only 0xa2
@@ -117,10 +117,10 @@ #undef FKS_TEST
  *
  * Software reset not being able to reset all registers is great! Especially
  * the fact that register 0x78 isn't reset is great when you wanna change back
- * to single dma operation (simplex): audio 2 is still operation, and uses the
- * same dma as audio 1: your ess changes into a funny echo machine.
+ * to single dma operation (simplex): audio 2 is still operational, and uses
+ * the same dma as audio 1: your ess changes into a funny echo machine.
  *
- * Received the new that ES1688 is detected as a ES1788. Did some thinking:
+ * Received the news that ES1688 is detected as a ES1788. Did some thinking:
  * the ES1887 detection scheme suggests in step 2 to try if bit 3 of register
  * 0x64 can be changed. This is inaccurate, first I inverted the * check: "If
  * can be modified, it's a 1688", which lead to a correct detection
@@ -135,7 +135,7 @@ #undef FKS_TEST
  * About recognition of ESS chips
  *
  * The distinction of ES688, ES1688, ES1788, ES1887 and ES1888 is described in
- * a (preliminary ??) datasheet on ES1887. It's aim is to identify ES1887, but
+ * a (preliminary ??) datasheet on ES1887. Its aim is to identify ES1887, but
  * during detection the text claims that "this chip may be ..." when a step
  * fails. This scheme is used to distinct between the above chips.
  * It appears however that some PnP chips like ES1868 are recognized as ES1788
@@ -156,9 +156,9 @@ #undef FKS_TEST
  *
  * The existing ES1688 support didn't take care of the ES1688+ recording
  * levels very well. Whenever a device was selected (recmask) for recording
- * it's recording level was loud, and it couldn't be changed. The fact that
+ * its recording level was loud, and it couldn't be changed. The fact that
  * internal register 0xb4 could take care of RECLEV, didn't work meaning until
- * it's value was restored every time the chip was reset; this reset the
+ * its value was restored every time the chip was reset; this reset the
  * value of 0xb4 too. I guess that's what 4front also had (have?) trouble with.
  *
  * About ES1887 support:
@@ -169,9 +169,9 @@ #undef FKS_TEST
  * the latter case the recording volumes are 0.
  * Now recording levels of inputs can be controlled, by changing the playback
  * levels. Futhermore several devices can be recorded together (which is not
- * possible with the ES1688.
+ * possible with the ES1688).
  * Besides the separate recording level control for each input, the common
- * recordig level can also be controlled by RECLEV as described above.
+ * recording level can also be controlled by RECLEV as described above.
  *
  * Not only ES1887 have this recording mixer. I know the following from the
  * documentation:
diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index f0a4869..5450a9e 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -143,7 +143,7 @@ static int cs5535audio_build_dma_packets
 	if (dma->periods == periods && dma->period_bytes == period_bytes)
 		return 0;
 
-	/* the u32 cast is okay because in snd*create we succesfully told
+	/* the u32 cast is okay because in snd*create we successfully told
    	   pci alloc that we're only 32 bit capable so the uppper will be 0 */
 	addr = (u32) substream->runtime->dma_addr;
 	desc_addr = (u32) dma->desc_buf.addr;

