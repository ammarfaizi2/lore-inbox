Return-Path: <linux-kernel-owner+w=401wt.eu-S1423074AbWLVOrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423074AbWLVOrN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWLVOrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:47:13 -0500
Received: from www17.your-server.de ([213.133.104.17]:1816 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423074AbWLVOrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:47:12 -0500
Message-ID: <458BEAA9.6010503@m3y3r.de>
Date: Fri, 22 Dec 2006 15:24:41 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061126)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Section mismatch on current git head
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

What kind of problem is this:
1.) the one that should be fixed, but also can be ignored or
2.) the one that have to be fixed and ignorance is a bad idea?


WARNING: vmlinux - Section mismatch: reference to .init.data:boot_params 
from .text between '_text' (at offset 0xc0100029) and 'startup_32_smp'
WARNING: vmlinux - Section mismatch: reference to .init.data:boot_params 
from .text between '_text' (at offset 0xc0100037) and 'startup_32_smp'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:init_pg_tables_end from .text between '_text' (at offset 
0xc0100099) and 'startup_32_smp'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100126) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100130) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc010014f) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100160) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100166) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc010016c) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100172) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100188) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc0100192) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc010019b) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'checkCPUtype' (at offset 
0xc01001a1) and 'is486'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'check_x87' (at offset 
0xc010021b) and 'setup_pda'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:new_cpu_data from .text between 'check_x87' (at offset 
0xc010023a) and 'setup_pda'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:start_kernel from .text between 'is386' (at offset 
0xc0100215) and 'check_x87'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:smp_prepare_cpus from .text between 'init' (at offset 
0xc01003db) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:migration_init from .text between 'init' (at offset 
0xc01003e0) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:spawn_ksoftirqd from .text between 'init' (at offset 
0xc01003e5) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:smp_cpus_done from .text between 'init' (at offset 
0xc0100459) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:sched_init_smp from .text between 'init' (at offset 
0xc010045e) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:cpuset_init_smp from .text between 'init' (at offset 
0xc0100463) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:usermodehelper_init from .text between 'init' (at offset 
0xc010046d) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:driver_init 
from .text between 'init' (at offset 0xc0100472) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:sysctl_init 
from .text between 'init' (at offset 0xc0100477) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'init' (at offset 0xc010048c) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'init' (at offset 0xc01004ca) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:prepare_namespace from .text between 'init' (at offset 
0xc010058d) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:efi_set_rtc_mmss from .text between 'sync_cmos_clock' (at 
offset 0xc0105987) and 'get_cmos_time'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:machine_specific_memory_setup from .text between 
'memory_setup' (at offset 0xc01065d9) and 'i8259A_suspend'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:__alloc_bootmem from .text between 'init_gdt' (at offset 
0xc0108869) and 'cpu_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:__alloc_bootmem from .text between 'init_gdt' (at offset 
0xc010887f) and 'cpu_init'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:sysenter_setup from .text between 'identify_cpu' (at offset 
0xc0108d43) and 'display_cacheinfo'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:mtrr_bp_init from .text between 'identify_cpu' (at offset 
0xc0108d4d) and 'display_cacheinfo'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at 
offset 0xc010e020) and 'acpi_unmap_lsapic'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at 
offset 0xc010e04a) and 'acpi_unmap_lsapic'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:mp_override_legacy_irq from .text between 
'acpi_sci_ioapic_setup' (at offset 0xc010e062) and 'acpi_unmap_lsapic'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:acpi_sci_override_gsi from .text between 
'acpi_sci_ioapic_setup' (at offset 0xc010e068) and 'acpi_unmap_lsapic'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc01117ac) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc01117b8) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc01117c7) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc01117e6) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc01117ed) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc0111801) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'start_secondary' (at offset 0xc0111810) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data:maxcpus 
from .text between 'MP_processor_info' (at offset 0xc0111d7e) and 
'mp_register_lapic'
WARNING: vmlinux - Section mismatch: reference to 
.init.text:__init_begin from .text between 'free_initmem' (at offset 
0xc0116dd5) and 'do_test_wp_bit'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .text 
between 'online_page' (at offset 0xc0116e3b) and 'page_is_ram'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext 
from .text between 'core_kernel_text' (at offset 0xc012de6e) and 
'kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext 
from .text between 'core_kernel_text' (at offset 0xc012de77) and 
'kernel_text_address'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext 
from .text between 'get_symbol_pos' (at offset 0xc0138e3a) and 'reset_iter'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext 
from .text between 'get_symbol_pos' (at offset 0xc0138e41) and 'reset_iter'
WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext 
from .text between 'is_ksym_addr' (at offset 0xc01390c7) and 
'kallsyms_lookup'
WARNING: vmlinux - Section mismatch: reference to .init.text:_einittext 
from .text between 'is_ksym_addr' (at offset 0xc01390cf) and 
'kallsyms_lookup'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:initkmem_list3 from .text between 'set_up_list3s' (at offset 
0xc015e54d) and 's_stop'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'asus_hides_smbus_lpc' (at offset 0xc01d38b6) and 'quirk_sis_503'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text 
between 'asus_hides_smbus_lpc_ich6' (at offset 0xc01d3de0) and 
'quirk_cardbus_legacy'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:logo_linux_mono from .text between 'fb_find_logo' (at offset 
0xc01e991e) and 'cfb_fillrect'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:logo_linux_clut224 from .text between 'fb_find_logo' (at 
offset 0xc01e9928) and 'cfb_fillrect'
WARNING: vmlinux - Section mismatch: reference to 
.init.data:logo_linux_vga16 from .text between 'fb_find_logo' (at offset 
0xc01e992d) and 'cfb_fillrect'
Root device is (8, 2)
Boot sector 512 bytes.
Setup is 6887 bytes.
System is 1422 kB
