Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVATU5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVATU5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVATU5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:57:33 -0500
Received: from fmr13.intel.com ([192.55.52.67]:50829 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261924AbVATU4e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:56:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG?]: cpufreqency scaling - wrong frequency detected
Date: Thu, 20 Jan 2005 12:56:21 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003D1B31F@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?]: cpufreqency scaling - wrong frequency detected
Thread-Index: AcT/LH3OXIh/8AIUT1mnGLtb5kxyGQABa46Q
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Matthias-Christian Ott" <matthias.christian@tiscali.de>,
       <linux-kernel@vger.kernel.org>
Cc: <linux@brodo.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Zou, Nanhai" <nanhai.zou@intel.com>
X-OriginalArrivalTime: 20 Jan 2005 20:56:22.0287 (UTC) FILETIME=[7F53E9F0:01C4FF32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can you send the output of 'acpidmp' from this system to me? If acpidmp
is not already installed, you should be able to grab it from here.
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ 

Thanks,
Venki

>-----Original Message-----
>From: Matthias-Christian Ott [mailto:matthias.christian@tiscali.de] 
>Sent: Thursday, January 20, 2005 12:13 PM
>To: Linux Kernel Mailing List
>Cc: linux@brodo.de; Nakajima, Jun; Pallipadi, Venkatesh; Zou, Nanhai
>Subject: [BUG?]: cpufreqency scaling - wrong frequency detected
>
>Hi!
>The Kernel cpufrequency scaling modul seems to have a bug, it displays 
>the frequency of 14,60 Ghz. I don't enabled debugging in the 
>config, but 
>I hope this information can help you. I don't know if it's 
>really a bug, 
>so I send it to the mailing list instead of reporting it to 
>the bugzilla 
>bugtracking system. if you need additional information, I'll compile a 
>Kernel with cpufreq debugging.
>
>Matthias-Christian Ott
>
>[fox@iceowl ~]$ cat /proc/version
>Linux version 2.6.11-rc1-bk7-ott (root@iceowl.ott.dyndns.info) 
>(gcc-Version 3.4.3) #1 SMP Thu Jan 20 16:18:06 CET 2005
>
>[root@iceowl ~]# dmesg
>ACPI: RSDP (v000 MSISYS                                ) @ 0x000f7550
>ACPI: RSDT (v001 MSISYS MSI ACPI 0x42302e31 AWRD 0x00000000) @ 
>0x17ff3000
>ACPI: FADT (v001 MSISYS MSI ACPI 0x42302e31 AWRD 0x00000000) @ 
>0x17ff3040
>ACPI: MADT (v001 MSISYS AWRDACPI 0x42302e31 AWRD 0x00000000) @ 
>0x17ff6c40
>ACPI: DSDT (v001 MSISYS AWRDACPI 0x00001000 MSFT 0x0100000c) @ 
>0x00000000
>ACPI: PM-Timer IO Port: 0x4008
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
>Processor #0 15:1 APIC version 20
>ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
>IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high level)
>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>ACPI: IRQ0 used by override.
>ACPI: IRQ2 used by override.
>ACPI: IRQ9 used by override.
>Enabling APIC mode:  Flat.  Using 1 I/O APICs
>Using ACPI (MADT) for SMP configuration information
>Built 1 zonelists
>Kernel command line: root=/dev/discs/disc0/part1 
>video=vesafb:ywrap,mtrr 
>vga=0x318 elevator=cfq ro mem=393152K
>[..]
>CPU: After generic identify, caps: 3febfbff 00000000 00000000 00000000 
>00000000 00000000 00000000
>CPU: After vendor identify, caps: 3febfbff 00000000 00000000 00000000 
>00000000 00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 256K
>CPU: Hyper-Threading is disabled
>CPU: After all inits, caps: 3febfbff 00000000 00000000 
>00000080 00000000 
>00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU0: Thermal monitoring enabled
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>CPU0: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 02
>per-CPU timeslice cutoff: 731.50 usecs.
>[..]
>Total of 1 processors activated (3563.52 BogoMIPS).
>ENABLING IO-APIC IRQs
>..TIMER: vector=0x31 pin1=2 pin2=-1
>Brought up 1 CPUs
>CPU0 attaching sched-domain:
> domain 0: span 1
>  groups: 1
>  domain 1: span 1
>   groups: 1
>[..]
>ACPI: Subsystem revision 20041210
>    ACPI-1138: *** Error: Method execution failed [\STRC] (Node 
>d7fc3660), AE_AML_BUFFER_LIMIT
>    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] 
>(Node d7fc7420), AE_AML_BUFFER_LIMIT
>ACPI: Interpreter enabled
>ACPI: Using IOAPIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Transparent bridge - 0000:00:1e.0
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
>ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
>[..]
>ACPI: Power Button (FF) [PWRF]
>ACPI: Sleep Button (CM) [SLPB]
>ACPI: Fan [FAN] (on)
>ACPI: CPU0 (power states: C1[C1] C2[C2])
>ACPI: Processor [CPU0] (supports 2 throttling states)
>ACPI: Thermal Zone [THRM] (22 C)
>[..]
>p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
>[..]
>
>[root@iceowl ~]# cat /proc/cpuinfo
>processor       : 0
>vendor_id       : GenuineIntel
>cpu family      : 15
>model           : 1
>model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
>stepping        : 2
>cpu MHz         : 1800.257
>cache size      : 256 KB
>physical id     : 0
>siblings        : 1
>fdiv_bug        : no
>hlt_bug         : no
>f00f_bug        : no
>coma_bug        : no
>fpu             : yes
>fpu_exception   : yes
>cpuid level     : 2
>wp              : yes
>flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
>bogomips        : 3563.52
>
>[root@iceowl ~]# cat 
>/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
>14600000
>
>[root@iceowl ~]# cat 
>/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
>3650000 5475000 7300000 9125000 10950000 12775000 14600000
>
>[root@iceowl ~]# cat 
>/home/fox/builds/kernel/kernel-2.6.10-rc1-ott/config
>[..]
>CONFIG_X86_PC=y
>[..]
>CONFIG_MPENTIUM4=y
>[..]
>CONFIG_X86_GENERIC=y
>CONFIG_X86_CMPXCHG=y
>CONFIG_X86_XADD=y
>CONFIG_X86_L1_CACHE_SHIFT=7
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_GENERIC_CALIBRATE_DELAY=y
>CONFIG_X86_WP_WORKS_OK=y
>CONFIG_X86_INVLPG=y
>CONFIG_X86_BSWAP=y
>CONFIG_X86_POPAD_OK=y
>CONFIG_X86_GOOD_APIC=y
>CONFIG_X86_INTEL_USERCOPY=y
>CONFIG_X86_USE_PPRO_CHECKSUM=y
>CONFIG_HPET_TIMER=y
>CONFIG_SMP=y
>CONFIG_NR_CPUS=4
>CONFIG_SCHED_SMT=y
>CONFIG_PREEMPT=y
>CONFIG_PREEMPT_BKL=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y
>CONFIG_X86_TSC=y
>CONFIG_X86_MCE=y
>CONFIG_X86_MCE_NONFATAL=m
>CONFIG_X86_MCE_P4THERMAL=y
>CONFIG_TOSHIBA=m
>CONFIG_I8K=m
>[..]
>CONFIG_PM=y
># CONFIG_PM_DEBUG is not set
>CONFIG_SOFTWARE_SUSPEND=y
>CONFIG_PM_STD_PARTITION=""
>[..]
>CONFIG_ACPI=y
>CONFIG_ACPI_BOOT=y
>CONFIG_ACPI_INTERPRETER=y
>CONFIG_ACPI_SLEEP=y
>CONFIG_ACPI_SLEEP_PROC_FS=y
>CONFIG_ACPI_AC=y
>CONFIG_ACPI_BATTERY=y
>CONFIG_ACPI_BUTTON=y
>CONFIG_ACPI_VIDEO=y
>CONFIG_ACPI_FAN=y
>CONFIG_ACPI_PROCESSOR=y
>CONFIG_ACPI_THERMAL=y
>CONFIG_ACPI_ASUS=m
>CONFIG_ACPI_IBM=m
>CONFIG_ACPI_TOSHIBA=m
>CONFIG_ACPI_BLACKLIST_YEAR=0
># CONFIG_ACPI_DEBUG is not set
>CONFIG_ACPI_BUS=y
>CONFIG_ACPI_EC=y
>CONFIG_ACPI_POWER=y
>CONFIG_ACPI_PCI=y
>CONFIG_ACPI_SYSTEM=y
>CONFIG_X86_PM_TIMER=y
># CONFIG_ACPI_CONTAINER is not set
>[..]
>CONFIG_CPU_FREQ=y
># CONFIG_CPU_FREQ_DEBUG is not set
>CONFIG_CPU_FREQ_STAT=m
>CONFIG_CPU_FREQ_STAT_DETAILS=y
># CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
>CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
>CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>CONFIG_CPU_FREQ_GOV_USERSPACE=y
>CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>CONFIG_CPU_FREQ_TABLE=y
>[..]
>CONFIG_X86_ACPI_CPUFREQ=y
>CONFIG_X86_POWERNOW_K6=m
>CONFIG_X86_POWERNOW_K7=m
>CONFIG_X86_POWERNOW_K7_ACPI=y
>CONFIG_X86_POWERNOW_K8=m
>CONFIG_X86_POWERNOW_K8_ACPI=y
>CONFIG_X86_GX_SUSPMOD=m
>CONFIG_X86_SPEEDSTEP_CENTRINO=m
>CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
>CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
>CONFIG_X86_SPEEDSTEP_ICH=m
>CONFIG_X86_SPEEDSTEP_SMI=m
>CONFIG_X86_P4_CLOCKMOD=y
>CONFIG_X86_CPUFREQ_NFORCE2=m
>CONFIG_X86_LONGRUN=m
>CONFIG_X86_LONGHAUL=m
>[..]
># CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
>CONFIG_X86_SPEEDSTEP_LIB=y
>CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
>[..]
>
>
>
