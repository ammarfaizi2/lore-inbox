Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbTCPEeg>; Sat, 15 Mar 2003 23:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbTCPEeg>; Sat, 15 Mar 2003 23:34:36 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:6788 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S262327AbTCPEef>; Sat, 15 Mar 2003 23:34:35 -0500
Date: Sat, 15 Mar 2003 20:45:24 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <20030316044524.GA6757@gnuppy.monkey.org>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]> <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10770000.1047787269@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 08:01:09PM -0800, Martin J. Bligh wrote:
> The patchset contains mainly scalability and NUMA stuff, and anything 
> else that stops things from irritating me. It's meant to be pretty stable, 
> not so much a testing ground for new stuff.
> 
> I'd be very interested in feedback from anyone willing to test on any 
> platform, however large or small.
> 
> NOTE - you will have to apply -bk3 before applying this release.
> ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.64-bk3.bz2
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.64/patch-2.5.64-bk3-mjb4.bz2
> 
> additional:
> 
> http://www.aracnet.com/~fletch/linux/2.5.59/pidmaps_nodepages

In file included from include/asm-i386/mach-summit/mach_mpparse.h:4,
                 from arch/i386/kernel/summit.c:32:
include/asm-i386/mach-summit/mach_apic.h: In function `init_apic_ldr':
include/asm-i386/mach-summit/mach_apic.h:37: warning: implicit declaration of function `apic_write_around'
include/asm-i386/mach-summit/mach_apic.h:38: warning: implicit declaration of function `apic_read'
include/asm-i386/mach-summit/mach_apic.h: In function `clustered_apic_check':
include/asm-i386/mach-summit/mach_apic.h:56: `nr_ioapics' undeclared (first use in this function)
include/asm-i386/mach-summit/mach_apic.h:56: (Each undeclared identifier is reported only once
include/asm-i386/mach-summit/mach_apic.h:56: for each function it appears in.)
include/asm-i386/mach-summit/mach_apic.h: At top level:
include/asm-i386/mach-summit/mach_apic.h:94: warning: `struct mpc_config_translation' declared inside parameter list
include/asm-i386/mach-summit/mach_apic.h:94: warning: its scope is only this definition or declaration, which is probably not what you want
include/asm-i386/mach-summit/mach_apic.h:94: warning: `struct mpc_config_processor' declared inside parameter list
include/asm-i386/mach-summit/mach_apic.h: In function `mpc_apic_id':
include/asm-i386/mach-summit/mach_apic.h:97: dereferencing pointer to incomplete type
include/asm-i386/mach-summit/mach_apic.h:98: dereferencing pointer to incomplete type
include/asm-i386/mach-summit/mach_apic.h:98: `CPU_FAMILY_MASK' undeclared (first use in this function)
include/asm-i386/mach-summit/mach_apic.h:99: dereferencing pointer to incomplete type
include/asm-i386/mach-summit/mach_apic.h:99: `CPU_MODEL_MASK' undeclared (first use in this function)
include/asm-i386/mach-summit/mach_apic.h:100: dereferencing pointer to incomplete type
include/asm-i386/mach-summit/mach_apic.h:101: dereferencing pointer to incomplete type
include/asm-i386/mach-summit/mach_apic.h: In function `check_phys_apicid_present':
include/asm-i386/mach-summit/mach_apic.h:113: `phys_cpu_present_map' undeclared (first use in this function)
In file included from arch/i386/kernel/summit.c:32:
include/asm-i386/mach-summit/mach_mpparse.h: At top level:
include/asm-i386/mach-summit/mach_mpparse.h:9: warning: `struct mpc_config_translation' declared inside parameter list
include/asm-i386/mach-summit/mach_mpparse.h:9: warning: `struct mpc_config_bus' declared inside parameter list
include/asm-i386/mach-summit/mach_mpparse.h: In function `mpc_oem_bus_info':
include/asm-i386/mach-summit/mach_mpparse.h:11: warning: implicit declaration of function `Dprintk'
include/asm-i386/mach-summit/mach_mpparse.h:11: dereferencing pointer to incomplete type
include/asm-i386/mach-summit/mach_mpparse.h: At top level:
include/asm-i386/mach-summit/mach_mpparse.h:15: warning: `struct mpc_config_translation' declared inside parameter list
include/asm-i386/mach-summit/mach_mpparse.h:15: warning: `struct mpc_config_bus' declared inside parameter list
include/asm-i386/mach-summit/mach_mpparse.h:20: warning: `struct mp_config_table' declared inside parameter list
arch/i386/kernel/summit.c: In function `setup_pci_node_map_for_wpeg':
arch/i386/kernel/summit.c:93: `mp_bus_id_to_node' undeclared (first use in this function)
arch/i386/kernel/summit.c: In function `setup_summit':
arch/i386/kernel/summit.c:133: `mp_bus_id_to_node' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/summit.o] Error 1
make: *** [arch/i386/kernel] Error 2

-------------------------------------------------------------------------------

bill

