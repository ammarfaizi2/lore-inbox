Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDWVNL>; Mon, 23 Apr 2001 17:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbRDWVNC>; Mon, 23 Apr 2001 17:13:02 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:18618 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131990AbRDWVMg>;
	Mon, 23 Apr 2001 17:12:36 -0400
Message-Id: <m14rndC-000OdmC@amadeus.home.nl>
Date: Mon, 23 Apr 2001 22:12:26 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: linux-kernel@vger.kernel.org
Subject: [patch] fix broken symbols (was Re: OK, let's try ...)
X-Newsgroups: fenrus.linux.kernel
X-Sarcasm: high
In-Reply-To: <20010420203700.E21392@thyrsus.com> <20010420173514.A21392@thyrsus.com> <E14qjmd-0002QD-00@the-village.bc.nu> <1164.987856333@redhat.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1164.987856333@redhat.com> you wrote:

> esr@thyrsus.com said:
> If the symbol has the letters 'F', 'I', 'S' and 'H' in it, in any order, 
> then it's broken.

First batch of fixes for these broken symbols

--- ./arch/i386/config.in	Thu Jan 18 14:36:59 2001
+++ ./arch/i386/config.in.fixed	Mon Apr 23 11:23:34 2001
@@ -47,7 +47,7 @@
 
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 4
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -56,85 +56,85 @@
    define_bool CONFIG_X86_POPAD_OK y
 fi
 if [ "$CONFIG_M486" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
 fi
 if [ "$CONFIG_M586" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
 fi
 if [ "$CONFIG_M586MMX" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
 fi
 if [ "$CONFIG_M686" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 7
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MK7" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 6
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_TSC y
 fi
 if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_int  CONFIG_X86_L1_CACESRE_SESRIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_PPRO_CESRECKSUM y
 fi
-tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
+tristate 'Toshiba Laptop support' CONFIG_TOSESRIBA
 
 tristate '/dev/cpu/microcode - Intel IA32 CPU microcode support' CONFIG_MICROCODE
 tristate '/dev/cpu/*/msr - Model-specific register support' CONFIG_X86_MSR
--- ./arch/ia64/config.in	Wed Feb 28 18:26:46 2001
+++ ./arch/ia64/config.in.fixed	Mon Apr 23 11:23:34 2001
@@ -27,7 +27,7 @@
 choice 'IA-64 system type'					\
 	"generic		CONFIG_IA64_GENERIC		\
 	 DIG-compliant		CONFIG_IA64_DIG			\
-	 HP-simulator		CONFIG_IA64_HP_SIM		\
+	 HP-simulator		CONFIG_IA64_ESRP_SIM		\
 	 SGI-SN1		CONFIG_IA64_SGI_SN1" generic
 
 choice 'Kernel page size'						\
@@ -52,8 +52,8 @@
 	fi
 	bool '  Force interrupt redirection' CONFIG_IA64_HAVE_IRQREDIR
 	bool '  Enable use of global TLB purge instruction (ptc.g)' CONFIG_ITANIUM_PTCG
-	bool '  Enable SoftSDV hacks' CONFIG_IA64_SOFTSDV_HACKS
-	bool '  Enable AzusA hacks' CONFIG_IA64_AZUSA_HACKS
+	bool '  Enable SoftSDV hacks' CONFIG_IA64_SOFTSDV_ESRACKS
+	bool '  Enable AzusA hacks' CONFIG_IA64_AZUSA_ESRACKS
 	bool '  Enable IA-64 Machine Check Abort' CONFIG_IA64_MCA
 	bool '  Enable ACPI 2.0 with errata 1.3' CONFIG_ACPI20
 	bool '  ACPI kernel configuration manager (EXPERIMENTAL)' CONFIG_ACPI_KERNEL_CONFIG
@@ -76,9 +76,9 @@
 	define_bool CONFIG_IA64_BRL_EMU y
 	define_bool CONFIG_IA64_MCA y
 	define_bool CONFIG_ITANIUM y
-	define_bool CONFIG_SGI_IOC3_ETH y
+	define_bool CONFIG_SGI_IOC3_ETESR y
 	define_bool CONFIG_PERCPU_IRQ y
-	define_int  CONFIG_CACHE_LINE_SHIFT 7
+	define_int  CONFIG_CACESRE_LINE_SESRIFT 7
 	bool '  Enable DISCONTIGMEM support' CONFIG_DISCONTIGMEM
 	bool '	Enable NUMA support' CONFIG_NUMA
 fi
@@ -96,7 +96,7 @@
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
-if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
+if [ "$CONFIG_IA64_ESRP_SIM" = "n" ]; then
 
 bool 'PCI support' CONFIG_PCI
 source drivers/pci/Config.in
@@ -118,7 +118,7 @@
   source net/Config.in
 fi
 
-if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
+if [ "$CONFIG_IA64_ESRP_SIM" = "n" ]; then
 
 source drivers/mtd/Config.in
 source drivers/pnp/Config.in
@@ -151,7 +151,7 @@
 fi
 endmenu
 
-if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
+if [ "$CONFIG_IA64_ESRP_SIM" = "n" ]; then
 
 if [ "$CONFIG_NET" = "y" ]; then
   mainmenu_option next_comment
@@ -209,7 +209,7 @@
   endmenu
 fi
 
-if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
+if [ "$CONFIG_IA64_ESRP_SIM" = "n" ]; then
 
 mainmenu_option next_comment
 comment 'Sound'
@@ -224,11 +224,11 @@
 
 fi # !HP_SIM
 
-if [ "$CONFIG_IA64_HP_SIM" != "n" -o "$CONFIG_IA64_GENERIC" != "n" ]; then
+if [ "$CONFIG_IA64_ESRP_SIM" != "n" -o "$CONFIG_IA64_GENERIC" != "n" ]; then
   mainmenu_option next_comment
   comment 'Simulated drivers'
 
-  tristate 'Simulated Ethernet ' CONFIG_SIMETH
+  tristate 'Simulated Ethernet ' CONFIG_SIMETESR
   bool 'Simulated serial driver support' CONFIG_SIM_SERIAL
   if [ "$CONFIG_SCSI" != "n" ]; then
     bool 'Simulated SCSI disk' CONFIG_SCSI_SIM
@@ -252,8 +252,8 @@
 bool 'Early printk support (requires VGA!)' CONFIG_IA64_EARLY_PRINTK
 bool 'Turn on compare-and-exchange bug checking (slow!)' CONFIG_IA64_DEBUG_CMPXCHG
 bool 'Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
-bool 'Print possible IA64 hazards to console' CONFIG_IA64_PRINT_HAZARDS
+bool 'Print possible IA64 hazards to console' CONFIG_IA64_PRINT_ESRAZARDS
 bool 'Enable new unwind support' CONFIG_IA64_NEW_UNWIND
-bool 'Disable VHPT' CONFIG_DISABLE_VHPT
+bool 'Disable VHPT' CONFIG_DISABLE_VESRPT
 
 endmenu
--- ./arch/m68k/config.in	Fri Jan  5 14:14:35 2001
+++ ./arch/m68k/config.in.fixed	Mon Apr 23 11:23:35 2001
@@ -31,8 +31,8 @@
 
 bool 'Amiga support' CONFIG_AMIGA
 bool 'Atari support' CONFIG_ATARI
-dep_bool '  Hades support' CONFIG_HADES $CONFIG_ATARI
-if [ "$CONFIG_HADES" = "y" ]; then
+dep_bool '  Hades support' CONFIG_ESRADES $CONFIG_ATARI
+if [ "$CONFIG_ESRADES" = "y" ]; then
    define_bool CONFIG_PCI y
 else
    define_bool CONFIG_PCI n
@@ -74,9 +74,9 @@
 if [ "$CONFIG_ADVANCED" = "y" ]; then
    bool 'Use read-modify-write instructions' CONFIG_RMW_INSNS
    if [ "$CONFIG_SUN3" = "y" ]; then
-      define_bool CONFIG_SINGLE_MEMORY_CHUNK n
+      define_bool CONFIG_SINGLE_MEMORY_CESRUNK n
    else
-      bool 'Use one physical chunk of memory only' CONFIG_SINGLE_MEMORY_CHUNK
+      bool 'Use one physical chunk of memory only' CONFIG_SINGLE_MEMORY_CESRUNK
    fi
    if [ "$CONFIG_M68060" = "y" ]; then
       bool 'Use write-through caching for 68060 supervisor accesses' CONFIG_060_WRITETHROUGH
@@ -189,7 +189,7 @@
    if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
       int  'Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
    fi
-   dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
+   dep_tristate '  SCSI tape support' CONFIG_CESRR_DEV_ST $CONFIG_SCSI
    if [ "$CONFIG_BLK_DEV_ST" != "n" ]; then
       int  'Maximum number of SCSI tapes that can be loaded as modules' CONFIG_ST_EXTRA_DEVS 2
    fi
@@ -198,7 +198,7 @@
       bool '    Enable vendor-specific extensions (for SCSI CDROM)' CONFIG_BLK_DEV_SR_VENDOR
       int  'Maximum number of CDROM devices that can be loaded as modules' CONFIG_SR_EXTRA_DEVS 2
    fi
-   dep_tristate '  SCSI generic support' CONFIG_CHR_DEV_SG $CONFIG_SCSI
+   dep_tristate '  SCSI generic support' CONFIG_CESRR_DEV_SG $CONFIG_SCSI
 
    comment 'Some SCSI devices (e.g. CD jukebox) support multiple LUNs'
 
@@ -236,9 +236,9 @@
    if [ "$CONFIG_ATARI" = "y" ]; then
       dep_tristate 'Atari native SCSI support' CONFIG_ATARI_SCSI $CONFIG_SCSI
       if [ "$CONFIG_ATARI_SCSI" != "n" ]; then
-	 bool '  Long delays for Toshiba CD-ROMs' CONFIG_ATARI_SCSI_TOSHIBA_DELAY
+	 bool '  Long delays for Toshiba CD-ROMs' CONFIG_ATARI_SCSI_TOSESRIBA_DELAY
 	 bool '  Reset SCSI-devices at boottime' CONFIG_ATARI_SCSI_RESET_BOOT
-	 if [ "$CONFIG_HADES" = "y" ]; then
+	 if [ "$CONFIG_ESRADES" = "y" ]; then
 	    bool '  Hades SCSI DMA emulator' CONFIG_TT_DMA_EMUL
 	 fi
       fi
@@ -364,7 +364,7 @@
 
 if [ "$CONFIG_SERIAL_EXTENDED" = "y" ]; then
    bool '    Support more than 4 serial ports' CONFIG_SERIAL_MANY_PORTS
-   bool '    Support for sharing serial interrupts' CONFIG_SERIAL_SHARE_IRQ
+   bool '    Support for sharing serial interrupts' CONFIG_SERIAL_SESRARE_IRQ
 #   bool '    Autodetect IRQ - do not yet enable !!' CONFIG_SERIAL_DETECT_IRQ
    bool '    Support special multiport boards' CONFIG_SERIAL_MULTIPORT
    bool '    Support the Bell Technologies HUB6 card' CONFIG_HUB6
@@ -407,7 +407,7 @@
 if [ "$CONFIG_AMIGA" = "y" ]; then
    tristate 'Amiga builtin serial support' CONFIG_AMIGA_BUILTIN_SERIAL
    if [ "$CONFIG_AMIGA_PCMCIA" = "y" ]; then
-      tristate 'Hisoft Whippet PCMCIA serial support' CONFIG_WHIPPET_SERIAL
+      tristate 'Hisoft Whippet PCMCIA serial support' CONFIG_WESRIPPET_SERIAL
    fi
 fi
 if [ "$CONFIG_PARPORT" = "n" ]; then
@@ -456,7 +456,7 @@
 fi
 if [ "$CONFIG_SUN3X_ZS" = "y" ]; then
    define_bool CONFIG_SBUS y
-   define_bool CONFIG_SBUSCHAR y
+   define_bool CONFIG_SBUSCESRAR y
    define_bool CONFIG_SUN_SERIAL y
 else
    define_bool CONFIG_SBUS n
@@ -494,7 +494,7 @@
 bool 'Watchdog Timer Support'	CONFIG_WATCHDOG
 if [ "$CONFIG_WATCHDOG" != "n" ]; then
    bool '  Disable watchdog shutdown on close' CONFIG_WATCHDOG_NOWAYOUT
-   bool '  Software Watchdog' CONFIG_SOFT_WATCHDOG
+   bool '  Software Watchdog' CONFIG_SOFT_WATCESRDOG
 fi
 if [ "$CONFIG_ATARI" = "y" ]; then
    bool 'Enhanced Real Time Clock Support' CONFIG_RTC
--- ./arch/mips/config.in	Tue Dec  5 13:30:39 2000
+++ ./arch/mips/config.in.fixed	Mon Apr 23 11:23:35 2001
@@ -119,20 +119,20 @@
 bool 'Override CPU Options' CONFIG_CPU_ADVANCED
 
 if [ "$CONFIG_CPU_ADVANCED" = "y" ]; then
-   bool '  ll/sc Instructions available' CONFIG_CPU_HAS_LLSC
-   bool '  Writeback Buffer available' CONFIG_CPU_HAS_WB
+   bool '  ll/sc Instructions available' CONFIG_CPU_ESRAS_LLSC
+   bool '  Writeback Buffer available' CONFIG_CPU_ESRAS_WB
 else
    if [ "$CONFIG_CPU_R3000" = "y" ]; then
       if [ "$CONFIG_DECSTATION" = "y" ]; then
-	 define_bool CONFIG_CPU_HAS_LLSC n
-	 define_bool CONFIG_CPU_HAS_WB y
+	 define_bool CONFIG_CPU_ESRAS_LLSC n
+	 define_bool CONFIG_CPU_ESRAS_WB y
       else
-	 define_bool CONFIG_CPU_HAS_LLSC n
-	 define_bool CONFIG_CPU_HAS_WB n
+	 define_bool CONFIG_CPU_ESRAS_LLSC n
+	 define_bool CONFIG_CPU_ESRAS_WB n
       fi
    else
-      define_bool CONFIG_CPU_HAS_LLSC y
-      define_bool CONFIG_CPU_HAS_WB n
+      define_bool CONFIG_CPU_ESRAS_LLSC y
+      define_bool CONFIG_CPU_ESRAS_WB n
    fi
 fi
 endmenu
--- ./arch/mips64/config.in	Wed Feb 28 18:26:59 2001
+++ ./arch/mips64/config.in.fixed	Mon Apr 23 11:23:35 2001
@@ -19,7 +19,7 @@
    bool '  NUMA support' CONFIG_NUMA
    bool '  Mapped kernel support' CONFIG_MAPPED_KERNEL
    bool '  Kernel text replication support' CONFIG_REPLICATE_KTEXT
-   bool '  Exception handler replication support' CONFIG_REPLICATE_EXHANDLERS
+   bool '  Exception handler replication support' CONFIG_REPLICATE_EXESRANDLERS
    bool '  Multi-Processing support' CONFIG_SMP
    #bool '  IP27 XXL' CONFIG_SGI_SN0_XXL
 fi
@@ -31,7 +31,7 @@
 unset CONFIG_ARC32
 unset CONFIG_ARC64
 unset CONFIG_BINFMT_ELF32
-unset CONFIG_BOARD_SCACHE
+unset CONFIG_BOARD_SCACESRE
 unset CONFIG_BOOT_ELF32
 unset CONFIG_BOOT_ELF64
 unset CONFIG_COHERENT_IO
@@ -41,7 +41,7 @@
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    define_bool CONFIG_BOOT_ELF32 y
    define_bool CONFIG_ARC32 y
-   define_bool CONFIG_BOARD_SCACHE y
+   define_bool CONFIG_BOARD_SCACESRE y
    define_bool CONFIG_ARC_MEMORY y
    define_bool CONFIG_SGI y
 fi
--- ./arch/ppc/config.in	Wed Mar 21 17:43:45 2001
+++ ./arch/ppc/config.in.fixed	Mon Apr 23 11:23:36 2001
@@ -103,7 +103,7 @@
 fi
 
 if [ "$CONFIG_ALL_PPC" != "y" ];then
-  define_bool CONFIG_MACH_SPECIFIC y
+  define_bool CONFIG_MACESR_SPECIFIC y
 fi
 
 if [ "$CONFIG_4xx" = "y" -o "$CONFIG_8xx" = "y" ]; then
--- ./arch/s390/config.in	Wed Feb 28 18:27:08 2001
+++ ./arch/s390/config.in.fixed	Mon Apr 23 11:23:36 2001
@@ -9,7 +9,7 @@
 define_bool CONFIG_UID16 y
 
 mainmenu_name "Linux Kernel Configuration"
-define_bool CONFIG_ARCH_S390 y
+define_bool CONFIG_ARCESR_S390 y
 
 mainmenu_option next_comment
 comment 'Code maturity level options'
--- ./arch/sh/config.in	Fri Jan  5 14:14:35 2001
+++ ./arch/sh/config.in.fixed	Mon Apr 23 11:23:36 2001
@@ -4,7 +4,7 @@
 #
 mainmenu_name "Linux/SuperH Kernel Configuration"
 
-define_bool CONFIG_SUPERH y
+define_bool CONFIG_SUPERESR y
 
 define_bool CONFIG_UID16 y
 
@@ -25,49 +25,49 @@
 mainmenu_option next_comment
 comment 'Processor type and features'
 choice 'SuperH system type'					\
-	"Generic		CONFIG_SH_GENERIC		\
-	 SolutionEngine		CONFIG_SH_SOLUTION_ENGINE	\
-	 Overdrive		CONFIG_SH_OVERDRIVE		\
-	 HP620			CONFIG_SH_HP620			\
-	 HP680			CONFIG_SH_HP680			\
-	 HP690			CONFIG_SH_HP690			\
-	 CqREEK			CONFIG_SH_CQREEK		\
-	 DMIDA			CONFIG_SH_DMIDA    		\
-	 EC3104			CONFIG_SH_EC3104		\
-	 Dreamcast		CONFIG_SH_DREAMCAST		\
-	 BareCPU		CONFIG_SH_UNKNOWN" Generic
-
-define_bool CONFIG_SH_RTC y
-
-if [ "$CONFIG_SH_HP620" = "y" -o "$CONFIG_SH_HP680" = "y" -o \
-     "$CONFIG_SH_HP690" = "y" ]; then
-	define_bool CONFIG_SH_HP600 y
+	"Generic		CONFIG_SESR_GENERIC		\
+	 SolutionEngine		CONFIG_SESR_SOLUTION_ENGINE	\
+	 Overdrive		CONFIG_SESR_OVERDRIVE		\
+	 HP620			CONFIG_SESR_ESRP620			\
+	 HP680			CONFIG_SESR_ESRP680			\
+	 HP690			CONFIG_SESR_ESRP690			\
+	 CqREEK			CONFIG_SESR_CQREEK		\
+	 DMIDA			CONFIG_SESR_DMIDA    		\
+	 EC3104			CONFIG_SESR_EC3104		\
+	 Dreamcast		CONFIG_SESR_DREAMCAST		\
+	 BareCPU		CONFIG_SESR_UNKNOWN" Generic
+
+define_bool CONFIG_SESR_RTC y
+
+if [ "$CONFIG_SESR_ESRP620" = "y" -o "$CONFIG_SESR_ESRP680" = "y" -o \
+     "$CONFIG_SESR_ESRP690" = "y" ]; then
+	define_bool CONFIG_SESR_ESRP600 y
 fi
 
 choice 'Processor type' \
-   "SH7707 CONFIG_CPU_SUBTYPE_SH7707 \
-    SH7708 CONFIG_CPU_SUBTYPE_SH7708 \
-    SH7709 CONFIG_CPU_SUBTYPE_SH7709 \
-    SH7750 CONFIG_CPU_SUBTYPE_SH7750" SH7708
-if [ "$CONFIG_CPU_SUBTYPE_SH7707" = "y" ]; then
-   define_bool CONFIG_CPU_SH3 y
-   define_bool CONFIG_CPU_SH4 n
-fi
-if [ "$CONFIG_CPU_SUBTYPE_SH7708" = "y" ]; then
-   define_bool CONFIG_CPU_SH3 y
-   define_bool CONFIG_CPU_SH4 n
-fi
-if [ "$CONFIG_CPU_SUBTYPE_SH7709" = "y" ]; then
-   define_bool CONFIG_CPU_SH3 y
-   define_bool CONFIG_CPU_SH4 n
-fi
-if [ "$CONFIG_CPU_SUBTYPE_SH7750" = "y" ]; then
-   define_bool CONFIG_CPU_SH3 n
-   define_bool CONFIG_CPU_SH4 y
+   "SH7707 CONFIG_CPU_SUBTYPE_SESR7707 \
+    SH7708 CONFIG_CPU_SUBTYPE_SESR7708 \
+    SH7709 CONFIG_CPU_SUBTYPE_SESR7709 \
+    SH7750 CONFIG_CPU_SUBTYPE_SESR7750" SH7708
+if [ "$CONFIG_CPU_SUBTYPE_SESR7707" = "y" ]; then
+   define_bool CONFIG_CPU_SESR3 y
+   define_bool CONFIG_CPU_SESR4 n
+fi
+if [ "$CONFIG_CPU_SUBTYPE_SESR7708" = "y" ]; then
+   define_bool CONFIG_CPU_SESR3 y
+   define_bool CONFIG_CPU_SESR4 n
+fi
+if [ "$CONFIG_CPU_SUBTYPE_SESR7709" = "y" ]; then
+   define_bool CONFIG_CPU_SESR3 y
+   define_bool CONFIG_CPU_SESR4 n
+fi
+if [ "$CONFIG_CPU_SUBTYPE_SESR7750" = "y" ]; then
+   define_bool CONFIG_CPU_SESR3 n
+   define_bool CONFIG_CPU_SESR4 y
 fi
 bool 'Little Endian' CONFIG_CPU_LITTLE_ENDIAN
-if [ "$CONFIG_SH_SOLUTION_ENGINE" = "y" -o "$CONFIG_SH_HP600" = "y" -o \
-     "$CONFIG_SH_OVERDRIVE" = "y" ]; then
+if [ "$CONFIG_SESR_SOLUTION_ENGINE" = "y" -o "$CONFIG_SESR_ESRP600" = "y" -o \
+     "$CONFIG_SESR_OVERDRIVE" = "y" ]; then
   define_hex CONFIG_MEMORY_START 0c000000
 else
   hex 'Physical memory start address' CONFIG_MEMORY_START 08000000
@@ -87,7 +87,7 @@
 
 bool 'Networking support' CONFIG_NET
 
-if [ "$CONFIG_SH_GENERIC" = "y" -o "$CONFIG_SH_SOLUTION_ENGINE" = "y" -o "$CONFIG_SH_UNKNOWN" = "y" ]; then
+if [ "$CONFIG_SESR_GENERIC" = "y" -o "$CONFIG_SESR_SOLUTION_ENGINE" = "y" -o "$CONFIG_SESR_UNKNOWN" = "y" ]; then
   bool 'Compact Flash Enabler support' CONFIG_CF_ENABLER
 fi
 
@@ -204,8 +204,8 @@
 fi
 
 tristate 'Serial (8250, 16450, 16550 or compatible) support' CONFIG_SERIAL
-tristate 'Serial (SCI, SCIF) support' CONFIG_SH_SCI
-if [ "$CONFIG_SERIAL" = "y" -o "$CONFIG_SH_SCI" = "y" ]; then
+tristate 'Serial (SCI, SCIF) support' CONFIG_SESR_SCI
+if [ "$CONFIG_SERIAL" = "y" -o "$CONFIG_SESR_SCI" = "y" ]; then
    bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
 fi
 comment 'Unix 98 PTY support'
@@ -214,8 +214,8 @@
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
 fi
 
-if [ "$CONFIG_SH_GENERIC" = "y" -o \
-     "$CONFIG_SH_OVERDRIVE" = "y" -o "$CONFIG_SH_SOLUTION_ENGINE" = "y" ]; then
+if [ "$CONFIG_SESR_GENERIC" = "y" -o \
+     "$CONFIG_SESR_OVERDRIVE" = "y" -o "$CONFIG_SESR_SOLUTION_ENGINE" = "y" ]; then
   bool 'Heartbeat LED' CONFIG_HEARTBEAT
 fi
 
@@ -260,9 +260,9 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
-bool 'Use LinuxSH standard BIOS' CONFIG_SH_STANDARD_BIOS
-if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
-   bool 'GDB Stub kernel debug' CONFIG_DEBUG_KERNEL_WITH_GDB_STUB
-   bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
+bool 'Use LinuxSH standard BIOS' CONFIG_SESR_STANDARD_BIOS
+if [ "$CONFIG_SESR_STANDARD_BIOS" = "y" ]; then
+   bool 'GDB Stub kernel debug' CONFIG_DEBUG_KERNEL_WITESR_GDB_STUB
+   bool 'Early printk support' CONFIG_SESR_EARLY_PRINTK
 fi
 endmenu
--- ./arch/sparc/config.in	Wed Feb 28 18:27:21 2001
+++ ./arch/sparc/config.in.fixed	Mon Apr 23 11:23:36 2001
@@ -38,7 +38,7 @@
 define_bool CONFIG_MCA n
 define_bool CONFIG_PCMCIA n
 define_bool CONFIG_SBUS y
-define_bool CONFIG_SBUSCHAR y
+define_bool CONFIG_SBUSCESRAR y
 define_bool CONFIG_BUSMOUSE y
 define_bool CONFIG_SUN_MOUSE y
 define_bool CONFIG_SERIAL y
@@ -158,7 +158,7 @@
       int  'Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
    fi
 
-   dep_tristate '  SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
+   dep_tristate '  SCSI tape support' CONFIG_CESRR_DEV_ST $CONFIG_SCSI
 
    if [ "$CONFIG_BLK_DEV_ST" != "n" ]; then
       int  'Maximum number of SCSI tapes that can be loaded as modules' CONFIG_ST_EXTRA_DEVS 2
@@ -171,7 +171,7 @@
       int  'Maximum number of CDROM devices that can be loaded as modules' CONFIG_SR_EXTRA_DEVS 2
    fi
 
-   dep_tristate '  SCSI generic support' CONFIG_CHR_DEV_SG $CONFIG_SCSI
+   dep_tristate '  SCSI generic support' CONFIG_CESRR_DEV_SG $CONFIG_SCSI
 
    comment 'Some SCSI devices (e.g. CD jukebox) support multiple LUNs'
 
@@ -254,7 +254,7 @@
 mainmenu_option next_comment
 comment 'Watchdog'
 
-tristate 'Software watchdog' CONFIG_SOFT_WATCHDOG
+tristate 'Software watchdog' CONFIG_SOFT_WATCESRDOG
 endmenu
 
 mainmenu_option next_comment
--- ./arch/parisc/config.in	Wed Dec  6 18:08:37 2000
+++ ./arch/parisc/config.in.fixed	Mon Apr 23 11:23:37 2001
@@ -121,13 +121,13 @@
     int  'Maximum number of SCSI disks that can be loaded as modules' CONFIG_SD_EXTRA_DEVS 40
   fi
 
-  dep_tristate 'SCSI tape support' CONFIG_CHR_DEV_ST $CONFIG_SCSI
+  dep_tristate 'SCSI tape support' CONFIG_CESRR_DEV_ST $CONFIG_SCSI
   dep_tristate 'SCSI CDROM support' CONFIG_BLK_DEV_SR $CONFIG_SCSI
   if [ "$CONFIG_BLK_DEV_SR" != "n" ]; then
     bool '  Enable vendor-specific extensions (for SCSI CDROM)' CONFIG_BLK_DEV_SR_VENDOR
     int  'Maximum number of CDROM devices that can be loaded as modules' CONFIG_SR_EXTRA_DEVS 2
   fi
-  dep_tristate 'SCSI generic support' CONFIG_CHR_DEV_SG $CONFIG_SCSI
+  dep_tristate 'SCSI generic support' CONFIG_CESRR_DEV_SG $CONFIG_SCSI
 
   comment 'Some SCSI devices (e.g. CD jukebox) support multiple LUNs'
   bool 'Probe all LUNs on each SCSI device' CONFIG_SCSI_MULTI_LUN
