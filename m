Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276792AbSIVIOn>; Sun, 22 Sep 2002 04:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276815AbSIVIOn>; Sun, 22 Sep 2002 04:14:43 -0400
Received: from fes4-mail.whowhere.com ([209.202.220.170]:48554 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S276792AbSIVIOj>;
	Sun, 22 Sep 2002 04:14:39 -0400
To: linux-kernel@vger.kernel.org
Date: Sun, 22 Sep 2002 09:19:30 +0100
From: "svetljo" <svetljo@lycos.com>
Message-ID: <PKEDJKHEMGBEJAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: svetljo@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: make bzImage fails on 2.5.37 2.5.38 (linking) APIC
X-Sender-Ip: 131.188.24.131
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does uniprocessor APIC works?

arch/i386/kernel/built-in.o: In function `disconnect_bsp_APIC':
arch/i386/kernel/built-in.o(.text+0xe6a8): undefined reference to
`pic_mode'
arch/i386/kernel/built-in.o: In function `clear_IO_APIC':
arch/i386/kernel/built-in.o(.text+0xf5fb): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text+0xf631): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `IO_APIC_get_PCI_irq_vector':
arch/i386/kernel/built-in.o(.text+0xf6f6): undefined reference to
`mp_bus_id_to_pci_bus'
arch/i386/kernel/built-in.o(.text+0xf702): undefined reference to
`mp_irq_entries'
arch/i386/kernel/built-in.o(.text+0xf712): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text+0xf71c): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf725): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text+0xf72d): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf743): undefined reference to
`mp_bus_id_to_type'
arch/i386/kernel/built-in.o(.text+0xf75e): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf76e): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf781): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf7b5): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf7d0): undefined reference to
`mp_irq_entries'
arch/i386/kernel/built-in.o: In function `pin_2_irq':
arch/i386/kernel/built-in.o(.text+0xf802): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text+0xf831): undefined reference to
`mp_bus_id_to_type'
arch/i386/kernel/built-in.o(.text+0xf846): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o: In function `io_apic_set_pci_routing':
arch/i386/kernel/built-in.o(.text+0x10054): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o: In function `setup_memory':
arch/i386/kernel/built-in.o(.text.init+0x114a): undefined reference to
`find_smp_config'
arch/i386/kernel/built-in.o: In function `setup_arch':
arch/i386/kernel/built-in.o(.text.init+0x159a): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o(.text.init+0x15c1): undefined reference to
`get_smp_config'
arch/i386/kernel/built-in.o: In function `acpi_parse_lapic':
arch/i386/kernel/built-in.o(.text.init+0x4ee3): undefined reference to
`mp_register_lapic'
arch/i386/kernel/built-in.o: In function `acpi_parse_ioapic':
arch/i386/kernel/built-in.o(.text.init+0x4f93): undefined reference to
`mp_register_ioapic'
arch/i386/kernel/built-in.o: In function `acpi_parse_int_src_ovr':
arch/i386/kernel/built-in.o(.text.init+0x4fe3): undefined reference to`mp_override_legacy_irq'
arch/i386/kernel/built-in.o: In function `acpi_boot_init':
arch/i386/kernel/built-in.o(.text.init+0x5156): undefined reference to
`mp_register_lapic_address'
arch/i386/kernel/built-in.o(.text.init+0x51cf): undefined reference to
`mp_config_acpi_legacy_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5227): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o: In function `connect_bsp_APIC':
arch/i386/kernel/built-in.o(.text.init+0x5357): undefined reference to
`pic_mode'
arch/i386/kernel/built-in.o: In function `init_bsp_APIC':
arch/i386/kernel/built-in.o(.text.init+0x5442): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o: In function `setup_local_APIC':
arch/i386/kernel/built-in.o(.text.init+0x54bf): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/built-in.o(.text.init+0x54dc): undefined reference to
`pic_mode'
arch/i386/kernel/built-in.o: In function `detect_init_APIC':
arch/i386/kernel/built-in.o(.text.init+0x5704): undefined reference to
`mp_lapic_addr'
arch/i386/kernel/built-in.o(.text.init+0x570e): undefined reference to
`boot_cpu_physical_apicid'
arch/i386/kernel/built-in.o: In function `init_apic_mappings':
arch/i386/kernel/built-in.o(.text.init+0x57c9): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o(.text.init+0x57d7): undefined reference to
`mp_lapic_addr'
arch/i386/kernel/built-in.o(.text.init+0x57f9): undefined reference to
`boot_cpu_physical_apicid'
arch/i386/kernel/built-in.o(.text.init+0x5809): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5811): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o(.text.init+0x581c): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x583c): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x587b): undefined reference to
`boot_cpu_physical_apicid'
arch/i386/kernel/built-in.o: In function `APIC_init_uniprocessor':
arch/i386/kernel/built-in.o(.text.init+0x5b07): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o(.text.init+0x5b2d): undefined reference to
`boot_cpu_physical_apicid'
arch/i386/kernel/built-in.o(.text.init+0x5b34): undefined reference to
`apic_version'
arch/i386/kernel/built-in.o(.text.init+0x5b46): undefined reference to
`boot_cpu_physical_apicid'
arch/i386/kernel/built-in.o(.text.init+0x5b4c): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/built-in.o(.text.init+0x5b6d): undefined reference to
`smp_found_config'
arch/i386/kernel/built-in.o(.text.init+0x5b7f): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `find_irq_entry':
arch/i386/kernel/built-in.o(.text.init+0x5e88): undefined reference to
`mp_irq_entries'
arch/i386/kernel/built-in.o(.text.init+0x5e95): undefined reference to
`mp_irqs'arch/i386/kernel/built-in.o(.text.init+0x5e9a): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x5ec8): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5eda): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o: In function `find_isa_irq_pin':
arch/i386/kernel/built-in.o(.text.init+0x5ef8): undefined reference to
`mp_irq_entries'
arch/i386/kernel/built-in.o(.text.init+0x5f05): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5f0a): undefined reference to
`mp_bus_id_to_type'
arch/i386/kernel/built-in.o(.text.init+0x5f38): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5f44): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5f52): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o: In function `MPBIOS_polarity':
arch/i386/kernel/built-in.o(.text.init+0x5faf): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5fb7): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x5ff6): undefined reference to
`mp_bus_id_to_type'
arch/i386/kernel/built-in.o: In function `MPBIOS_trigger':
arch/i386/kernel/built-in.o(.text.init+0x6032): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x603a): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x608d): undefined reference to
`mp_bus_id_to_type'
arch/i386/kernel/built-in.o(.text.init+0x60b5): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o: In function `setup_IO_APIC_irqs':
arch/i386/kernel/built-in.o(.text.init+0x615d): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x62d7): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6389): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x641f): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6440): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6478): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o: In function `print_IO_APIC':
arch/i386/kernel/built-in.o(.text.init+0x658c): undefined reference to
`mp_irq_entries'
arch/i386/kernel/built-in.o(.text.init+0x65a2): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x65bc): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x663b): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6850): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6956): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6978): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `enable_IO_APIC':
arch/i386/kernel/built-in.o(.text.init+0x69db): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6a23): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `setup_ioapic_ids_from_mpc':
arch/i386/kernel/built-in.o(.text.init+0x6a5a): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/built-in.o(.text.init+0x6a79): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6ad9): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6aef): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6b62): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6b6e): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6b76): undefined reference to
`mp_irq_entries'
arch/i386/kernel/built-in.o(.text.init+0x6b81): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x6b9a): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6c3f): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6c5b): undefined reference to
`nr_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6c91): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6c9d): undefined reference to
`mp_irqs'
arch/i386/kernel/built-in.o(.text.init+0x6cbd): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o(.text.init+0x6d0b): undefined reference to
`mp_ioapics'
arch/i386/kernel/built-in.o: In function `io_apic_get_unique_id':
arch/i386/kernel/built-in.o(.text.init+0x6e16): undefined reference to
`phys_cpu_present_map'
drivers/built-in.o: In function `acpi_system_suspend':
drivers/built-in.o(.text+0x3c0fe): undefined reference to
`do_suspend_lowlevel'
drivers/built-in.o: In function `quirk_via_ioapic':
drivers/built-in.o(.text.init+0x628): undefined reference to
`nr_ioapics'
drivers/built-in.o: In function `acpi_bus_init':
drivers/built-in.o(.text.init+0x186c): undefined reference to
`mp_config_ioapic_for_sci'
drivers/built-in.o: In function `acpi_pci_irq_init':
drivers/built-in.o(.text.init+0x1f87): undefined reference to
`mp_parse_prt'
arch/i386/pci/built-in.o: In function `pirq_enable_irq':
arch/i386/pci/built-in.o(.text+0x2149): undefined reference to
`mp_irq_entries'
arch/i386/pci/built-in.o: In function `pcibios_irq_init':
arch/i386/pci/built-in.o(.text.init+0x9cb): undefined reference to
`mp_irq_entries'
arch/i386/pci/built-in.o: In function `pcibios_fixup_irqs':
arch/i386/pci/built-in.o(.text.init+0xa97): undefined reference to
`mp_irq_entries'
net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0x11566): undefined reference to
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0x115c5): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0x11603): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0x1179e): undefined reference to
`llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.text.init+0x6de): undefined reference to `llc_sap_open'
make: *** [vmlinux] Error 1

---
Svetoslav Dimitrov Slavtschev

svetljo@lycos.com
svetoslav@web.de



_____________________________________________________________
Play the Elvis® Scratch & Win for your chance to instantly win $10,000 Cash
- a 2003 Harley Davidson® Sportster® - 1 of 25,000 CD's - and more!
http://r.lycos.com/r/sagel_mail_scratch_tl/http://win.ipromotions.com/lycos_020801/index.asp?tc=7087 
