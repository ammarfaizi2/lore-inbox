Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275310AbTHGNcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275268AbTHGNcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:32:35 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:40394 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S275344AbTHGNay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:30:54 -0400
Date: Thu, 7 Aug 2003 15:30:53 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre10-ac1 -- lots of unresolved symbols
Message-ID: <20030807133053.GA18191@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=00000069&certdir=/usr/local/cafe/data/polish_ca/certs_31.12.2002/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got lots of unresolved symbols for 2.4.22-pre10-ac1, please help.
thanks in advance, P

ps. log and .config below:

cd /lib/modules/2.4.22-pre10-ac1; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre10-ac1; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/arch/i386/kernel/cpuid.o
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	boot_cpu_data
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/arch/i386/kernel/microcode.o
depmod: 	_mmx_memcpy
depmod: 	misc_deregister
depmod: 	__generic_copy_from_user
depmod: 	kmalloc
depmod: 	vfree
depmod: 	boot_cpu_data
depmod: 	kfree
depmod: 	misc_register
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	num_physpages
depmod: 	__vmalloc
depmod: 	printk
depmod: 	rwsem_down_read_failed
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/arch/i386/kernel/msr.o
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	boot_cpu_data
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/acpi/button.o
depmod: 	acpi_bus_generate_event
depmod: 	kmalloc
depmod: 	create_proc_entry
depmod: 	acpi_remove_fixed_event_handler
depmod: 	acpi_root_dir
depmod: 	acpi_install_notify_handler
depmod: 	proc_mkdir
depmod: 	acpi_bus_register_driver
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	acpi_evaluate_integer
depmod: 	acpi_install_fixed_event_handler
depmod: 	sprintf
depmod: 	acpi_bus_unregister_driver
depmod: 	printk
depmod: 	acpi_remove_notify_handler
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/acpi/fan.o
depmod: 	__generic_copy_from_user
depmod: 	acpi_bus_set_power
depmod: 	kmalloc
depmod: 	create_proc_entry
depmod: 	acpi_bus_get_power
depmod: 	acpi_root_dir
depmod: 	proc_mkdir
depmod: 	acpi_bus_register_driver
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	acpi_bus_unregister_driver
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/acpi/processor.o
depmod: 	acpi_bus_generate_event
depmod: 	acpi_os_free
depmod: 	__generic_copy_from_user
depmod: 	acpi_bus_get_device
depmod: 	kmalloc
depmod: 	acpi_set_register
depmod: 	create_proc_entry
depmod: 	pci_read_config_byte
depmod: 	acpi_root_dir
depmod: 	acpi_install_notify_handler
depmod: 	acpi_extract_package
depmod: 	acpi_evaluate_object
depmod: 	proc_mkdir
depmod: 	acpi_bus_register_driver
depmod: 	kfree
depmod: 	acpi_fadt
depmod: 	acpi_get_register
depmod: 	remove_proc_entry
depmod: 	acpi_evaluate_integer
depmod: 	sscanf
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	acpi_bus_unregister_driver
depmod: 	pci_find_subsys
depmod: 	printk
depmod: 	__const_udelay
depmod: 	acpi_get_handle
depmod: 	pm_idle
depmod: 	acpi_remove_notify_handler
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/block/floppy.o
depmod: 	blk_ioctl
depmod: 	_mmx_memcpy
depmod: 	max_sectors
depmod: 	register_disk
depmod: 	__wake_up
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	__release_region
depmod: 	check_disk_change
depmod: 	blk_cleanup_queue
depmod: 	tq_immediate
depmod: 	kmalloc
depmod: 	__wait_on_buffer
depmod: 	end_that_request_last
depmod: 	free_dma
depmod: 	get_options
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	unregister_blkdev
depmod: 	enable_hlt
depmod: 	permission
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	getblk
depmod: 	high_memory
depmod: 	register_blkdev
depmod: 	panic
depmod: 	ll_rw_block
depmod: 	end_that_request_first
depmod: 	free_pages
depmod: 	bh_task_vec
depmod: 	add_blkdev_randomness
depmod: 	request_dma
depmod: 	blk_size
depmod: 	del_timer
depmod: 	kfree
depmod: 	__run_task_queue
depmod: 	request_irq
depmod: 	add_wait_queue
depmod: 	blk_dev
depmod: 	blk_init_queue
depmod: 	sprintf
depmod: 	__invalidate_buffers
depmod: 	__brelse
depmod: 	__tasklet_hi_schedule
depmod: 	jiffies
depmod: 	__vmalloc
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	__const_udelay
depmod: 	blksize_size
depmod: 	ioport_resource
depmod: 	__generic_copy_to_user
depmod: 	disable_hlt
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/block/loop.o
depmod: 	blk_ioctl
depmod: 	flush_signals
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	register_disk
depmod: 	invalidate_bdev
depmod: 	kmem_cache_free
depmod: 	unlock_page
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	reparent_to_init
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	blk_queue_make_request
depmod: 	zone_table
depmod: 	blk_size
depmod: 	is_read_only
depmod: 	refile_buffer
depmod: 	kfree
depmod: 	do_generic_file_read
depmod: 	__run_task_queue
depmod: 	tq_disk
depmod: 	exit_files
depmod: 	find_or_create_page
depmod: 	blk_dev
depmod: 	fput
depmod: 	set_blocksize
depmod: 	_alloc_pages
depmod: 	set_device_ro
depmod: 	bh_cachep
depmod: 	sprintf
depmod: 	daemonize
depmod: 	fget
depmod: 	generic_make_request
depmod: 	__free_pages
depmod: 	printk
depmod: 	kernel_thread
depmod: 	blksize_size
depmod: 	kmem_cache_alloc
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/block/nbd.o
depmod: 	register_disk
depmod: 	sock_sendmsg
depmod: 	blk_cleanup_queue
depmod: 	blkdev_release_request
depmod: 	__up_wakeup
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	blk_queue_headactive
depmod: 	blk_size
depmod: 	dequeue_signal
depmod: 	sock_recvmsg
depmod: 	blk_dev
depmod: 	fput
depmod: 	blk_init_queue
depmod: 	fget
depmod: 	printk
depmod: 	blksize_size
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/block/rd.o
depmod: 	blk_ioctl
depmod: 	_mmx_memcpy
depmod: 	register_disk
depmod: 	unlock_page
depmod: 	__up_wakeup
depmod: 	blkdev_put
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	bdget
depmod: 	blk_queue_make_request
depmod: 	fail_writepage
depmod: 	zone_table
depmod: 	blk_size
depmod: 	refile_buffer
depmod: 	find_or_create_page
depmod: 	blk_dev
depmod: 	__invalidate_buffers
depmod: 	__free_pages
depmod: 	truncate_inode_pages
depmod: 	printk
depmod: 	blksize_size
depmod: 	__down_failed
depmod: 	hardsect_size
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/cdrom/cdrom.o
depmod: 	_mmx_memcpy
depmod: 	__generic_copy_from_user
depmod: 	check_disk_change
depmod: 	kmalloc
depmod: 	proc_dostring
depmod: 	proc_dointvec
depmod: 	unregister_sysctl_table
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: 	register_sysctl_table
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/char/drm/mga.o
depmod: 	remap_page_range
depmod: 	_mmx_memcpy
depmod: 	__wake_up
depmod: 	mtrr_add
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	inter_module_register
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	si_meminfo
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	inter_module_put
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	boot_cpu_data
depmod: 	inter_module_get
depmod: 	remove_wait_queue
depmod: 	high_memory
depmod: 	try_inc_mod_count
depmod: 	iounmap
depmod: 	free_pages
depmod: 	__ioremap
depmod: 	mtrr_del
depmod: 	block_all_signals
depmod: 	del_timer
depmod: 	__pollwait
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	pci_find_slot
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	kill_fasync
depmod: 	fasync_helper
depmod: 	add_wait_queue
depmod: 	do_mmap_pgoff
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	unblock_all_signals
depmod: 	jiffies
depmod: 	__vmalloc
depmod: 	printk
depmod: 	__const_udelay
depmod: 	inter_module_unregister
depmod: 	vmalloc_to_page
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/char/lp.o
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	interruptible_sleep_on_timeout
depmod: 	kfree
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	jiffies
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/char/rtc.o
depmod: 	misc_deregister
depmod: 	__wake_up
depmod: 	schedule
depmod: 	__release_region
depmod: 	create_proc_entry
depmod: 	no_llseek
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	proc_dointvec
depmod: 	unregister_sysctl_table
depmod: 	del_timer
depmod: 	mod_timer
depmod: 	__pollwait
depmod: 	misc_register
depmod: 	remove_proc_entry
depmod: 	request_irq
depmod: 	kill_fasync
depmod: 	fasync_helper
depmod: 	add_wait_queue
depmod: 	sprintf
depmod: 	jiffies
depmod: 	printk
depmod: 	__request_region
depmod: 	add_timer
depmod: 	ioport_resource
depmod: 	register_sysctl_table
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/i2c/i2c-algo-bit.o
depmod: 	schedule
depmod: 	__udelay
depmod: 	jiffies
depmod: 	printk
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/i2c/i2c-core.o
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	proc_bus
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	sprintf
depmod: 	printk
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/i2c/i2c-dev.o
depmod: 	__generic_copy_from_user
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/i2c/i2c-proc.o
depmod: 	_mmx_memcpy
depmod: 	__get_user_1
depmod: 	__get_user_4
depmod: 	__generic_copy_from_user
depmod: 	kmalloc
depmod: 	_ctype
depmod: 	__check_region
depmod: 	unregister_sysctl_table
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: 	ioport_resource
depmod: 	register_sysctl_table
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/ide/ide-cd.o
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	ide_wait_stat
depmod: 	ide_end_drive_cmd
depmod: 	ide_execute_command
depmod: 	max_sectors
depmod: 	ide_do_reset
depmod: 	blkdev_release_request
depmod: 	kmalloc
depmod: 	ide_register_module
depmod: 	end_that_request_last
depmod: 	ide_unregister_module
depmod: 	end_that_request_first
depmod: 	ide_dump_status
depmod: 	ide_unregister_subdriver
depmod: 	add_blkdev_randomness
depmod: 	blk_size
depmod: 	strstr
depmod: 	ide_do_drive_cmd
depmod: 	ide_scan_devices
depmod: 	ide_stall_queue
depmod: 	kfree
depmod: 	ide_set_handler
depmod: 	ide_register_subdriver
depmod: 	set_blocksize
depmod: 	set_device_ro
depmod: 	read_ahead
depmod: 	ide_init_drive_cmd
depmod: 	ide_add_setting
depmod: 	sprintf
depmod: 	jiffies
depmod: 	max_readahead
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/ide/pci/via82cxxx.o
depmod: 	pci_write_config_byte
depmod: 	ide_setup_dma
depmod: 	pci_read_config_byte
depmod: 	ide_pci_unregister_driver
depmod: 	pci_read_config_dword
depmod: 	pci_read_config_word
depmod: 	noautodma
depmod: 	system_bus_clock
depmod: 	ide_pci_register_driver
depmod: 	ide_config_drive_speed
depmod: 	pci_write_config_dword
depmod: 	pci_find_device
depmod: 	sprintf
depmod: 	ide_pci_register_host_proc
depmod: 	printk
depmod: 	ide_setup_pci_device
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/input/input.o
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	try_inc_mod_count
depmod: 	del_timer
depmod: 	mod_timer
depmod: 	sprintf
depmod: 	jiffies
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/input/keybdev.o
depmod: 	kmalloc
depmod: 	handle_scancode
depmod: 	__tasklet_schedule
depmod: 	keyboard_tasklet
depmod: 	kbd_ledfunc
depmod: 	kfree
depmod: 	kbd_refresh_leds
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/input/mousedev.o
depmod: 	__get_user_1
depmod: 	__wake_up
depmod: 	schedule
depmod: 	kmalloc
depmod: 	remove_wait_queue
depmod: 	__pollwait
depmod: 	kfree
depmod: 	kill_fasync
depmod: 	add_wait_queue
depmod: 	fasync_helper
depmod: 	add_mouse_randomness
depmod: 	printk
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/bttv.o
depmod: 	pci_write_config_byte
depmod: 	remap_page_range
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	pci_register_driver
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	pci_find_class
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	pci_read_config_byte
depmod: 	vfree
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	iounmap
depmod: 	__ioremap
depmod: 	request_module
depmod: 	zone_table
depmod: 	pci_read_config_word
depmod: 	do_gettimeofday
depmod: 	__pollwait
depmod: 	iomem_resource
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	request_irq
depmod: 	pci_unregister_driver
depmod: 	add_wait_queue
depmod: 	pci_set_master
depmod: 	pci_find_device
depmod: 	sprintf
depmod: 	jiffies
depmod: 	__vmalloc
depmod: 	__request_region
depmod: 	printk
depmod: 	irq_stat
depmod: 	__const_udelay
depmod: 	pci_pci_problems
depmod: 	vmalloc_to_page
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/msp3400.o
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	del_timer
depmod: 	mod_timer
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	sprintf
depmod: 	daemonize
depmod: 	jiffies
depmod: 	printk
depmod: 	kernel_thread
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/tda7432.o
depmod: 	kmalloc
depmod: 	kfree
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/tda9875.o
depmod: 	kmalloc
depmod: 	kfree
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/tda9887.o
depmod: 	kmalloc
depmod: 	kfree
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/tuner.o
depmod: 	kmalloc
depmod: 	kfree
depmod: 	printk
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/tvaudio.o
depmod: 	__wake_up
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	del_timer
depmod: 	mod_timer
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	daemonize
depmod: 	jiffies
depmod: 	printk
depmod: 	kernel_thread
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/tvmixer.o
depmod: 	__get_user_4
depmod: 	no_llseek
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/media/video/videodev.o
depmod: 	__generic_copy_from_user
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	no_llseek
depmod: 	try_inc_mod_count
depmod: 	panic
depmod: 	request_module
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	proc_root
depmod: 	sprintf
depmod: 	printk
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/8139cp.o
depmod: 	pci_write_config_byte
depmod: 	pci_set_power_state
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	eth_type_trans
depmod: 	schedule_timeout
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	pci_register_driver
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	pci_enable_device
depmod: 	pci_read_config_byte
depmod: 	alloc_etherdev
depmod: 	pci_disable_device
depmod: 	cpu_raise_softirq
depmod: 	free_irq
depmod: 	unregister_netdev
depmod: 	__out_of_line_bug
depmod: 	iounmap
depmod: 	pci_alloc_consistent
depmod: 	__ioremap
depmod: 	zone_table
depmod: 	pci_read_config_word
depmod: 	register_netdev
depmod: 	pci_set_dma_mask
depmod: 	pci_release_regions
depmod: 	kfree
depmod: 	request_irq
depmod: 	netif_rx
depmod: 	pci_unregister_driver
depmod: 	skb_over_panic
depmod: 	pci_set_master
depmod: 	pci_enable_wake
depmod: 	pci_write_config_word
depmod: 	jiffies
depmod: 	softnet_data
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__generic_copy_to_user
depmod: 	pci_request_regions
depmod: 	pci_set_mwi
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/8139too.o
depmod: 	flush_signals
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	eth_type_trans
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	pci_register_driver
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	pci_enable_device
depmod: 	pci_read_config_byte
depmod: 	alloc_etherdev
depmod: 	reparent_to_init
depmod: 	cpu_raise_softirq
depmod: 	free_irq
depmod: 	unregister_netdev
depmod: 	kill_proc
depmod: 	__out_of_line_bug
depmod: 	iounmap
depmod: 	pci_alloc_consistent
depmod: 	interruptible_sleep_on_timeout
depmod: 	__ioremap
depmod: 	pci_read_config_word
depmod: 	skb_copy_and_csum_dev
depmod: 	register_netdev
depmod: 	kfree
depmod: 	pci_release_regions
depmod: 	wait_for_completion
depmod: 	request_irq
depmod: 	netif_rx
depmod: 	pci_unregister_driver
depmod: 	skb_over_panic
depmod: 	pci_set_master
depmod: 	rtnl_unlock
depmod: 	pci_write_config_word
depmod: 	daemonize
depmod: 	jiffies
depmod: 	softnet_data
depmod: 	rtnl_lock
depmod: 	printk
depmod: 	complete_and_exit
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	__generic_copy_to_user
depmod: 	pci_request_regions
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/8390.o
depmod: 	_mmx_memcpy
depmod: 	enable_irq
depmod: 	eth_type_trans
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	ether_setup
depmod: 	kmalloc
depmod: 	cpu_raise_softirq
depmod: 	__out_of_line_bug
depmod: 	disable_irq_nosync
depmod: 	netif_rx
depmod: 	skb_over_panic
depmod: 	jiffies
depmod: 	softnet_data
depmod: 	printk
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/bsd_comp.o
depmod: 	kmalloc
depmod: 	vfree
depmod: 	kfree
depmod: 	__vmalloc
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/dummy.o
depmod: 	__kfree_skb
depmod: 	ether_setup
depmod: 	kmalloc
depmod: 	unregister_netdev
depmod: 	register_netdev
depmod: 	dev_alloc_name
depmod: 	kfree
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/hp100.o
depmod: 	eth_type_trans
depmod: 	schedule_timeout
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	__release_region
depmod: 	ether_setup
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	pci_enable_device
depmod: 	__check_region
depmod: 	cpu_raise_softirq
depmod: 	pcibios_present
depmod: 	free_irq
depmod: 	unregister_netdev
depmod: 	__out_of_line_bug
depmod: 	iounmap
depmod: 	pci_alloc_consistent
depmod: 	__ioremap
depmod: 	pci_read_config_word
depmod: 	skb_pad
depmod: 	register_netdev
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	___pskb_trim
depmod: 	request_irq
depmod: 	netif_rx
depmod: 	skb_over_panic
depmod: 	pci_find_device
depmod: 	pci_write_config_word
depmod: 	jiffies
depmod: 	softnet_data
depmod: 	__request_region
depmod: 	printk
depmod: 	irq_stat
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/mii.o
depmod: 	__netdev_watchdog_up
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/ne2k-pci.o
depmod: 	pci_register_driver
depmod: 	__release_region
depmod: 	pci_enable_device
depmod: 	alloc_etherdev
depmod: 	free_irq
depmod: 	unregister_netdev
depmod: 	register_netdev
depmod: 	kfree
depmod: 	request_irq
depmod: 	pci_unregister_driver
depmod: 	jiffies
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/ppp_async.o
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	n_tty_ioctl
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	skb_under_panic
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	__out_of_line_bug
depmod: 	tty_register_ldisc
depmod: 	kfree
depmod: 	___pskb_trim
depmod: 	skb_over_panic
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/ppp_deflate.o
depmod: 	kmalloc
depmod: 	vfree
depmod: 	kfree
depmod: 	__vmalloc
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/ppp_generic.o
depmod: 	register_netdevice
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	skb_under_panic
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	unregister_netdevice
depmod: 	__up_wakeup
depmod: 	cpu_raise_softirq
depmod: 	remove_wait_queue
depmod: 	__out_of_line_bug
depmod: 	request_module
depmod: 	__pollwait
depmod: 	kfree
depmod: 	___pskb_trim
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	netif_rx
depmod: 	skb_over_panic
depmod: 	add_wait_queue
depmod: 	dev_close
depmod: 	rtnl_unlock
depmod: 	sprintf
depmod: 	jiffies
depmod: 	rtnl_lock
depmod: 	softnet_data
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	rwsem_down_read_failed
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/ppp_synctty.o
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	n_tty_ioctl
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	skb_under_panic
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	__out_of_line_bug
depmod: 	tty_register_ldisc
depmod: 	kfree
depmod: 	skb_over_panic
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/net/slhc.o
depmod: 	_mmx_memcpy
depmod: 	kmalloc
depmod: 	kfree
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/parport/parport.o
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	schedule
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	_ctype
depmod: 	__up_wakeup
depmod: 	proc_doulongvec_ms_jiffies_minmax
depmod: 	request_module
depmod: 	strstr
depmod: 	unregister_sysctl_table
depmod: 	del_timer
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	jiffies
depmod: 	proc_dointvec_minmax
depmod: 	printk
depmod: 	add_timer
depmod: 	__const_udelay
depmod: 	register_sysctl_table
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/parport/parport_pc.o
depmod: 	pci_write_config_byte
depmod: 	pci_register_driver
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	probe_irq_off
depmod: 	pci_enable_device
depmod: 	free_dma
depmod: 	__check_region
depmod: 	pci_read_config_byte
depmod: 	free_irq
depmod: 	pci_read_config_dword
depmod: 	pci_match_device
depmod: 	kfree
depmod: 	pci_devices
depmod: 	request_irq
depmod: 	pci_unregister_driver
depmod: 	pci_write_config_dword
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: 	probe_irq_on
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/pnp/isa-pnp.o
depmod: 	_mmx_memcpy
depmod: 	__generic_copy_from_user
depmod: 	__release_region
depmod: 	vsprintf
depmod: 	kmalloc
depmod: 	free_dma
depmod: 	__up_wakeup
depmod: 	__check_region
depmod: 	create_proc_entry
depmod: 	proc_bus
depmod: 	vfree
depmod: 	pcibios_penalize_isa_irq
depmod: 	free_irq
depmod: 	proc_mkdir
depmod: 	request_dma
depmod: 	iomem_resource
depmod: 	kfree
depmod: 	pci_devices
depmod: 	remove_proc_entry
depmod: 	request_irq
depmod: 	simple_strtoul
depmod: 	proc_root
depmod: 	sprintf
depmod: 	__vmalloc
depmod: 	__request_region
depmod: 	printk
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/scsi/scsi_mod.o
depmod: 	send_sig
depmod: 	blk_seg_merge_ok
depmod: 	_mmx_memcpy
depmod: 	__get_user_1
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	__release_region
depmod: 	blk_max_low_pfn
depmod: 	blk_cleanup_queue
depmod: 	generic_unplug_device
depmod: 	blkdev_release_request
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	kdevname
depmod: 	free_dma
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	blk_nohighio
depmod: 	__get_free_pages
depmod: 	reparent_to_init
depmod: 	bread
depmod: 	complete
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	high_memory
depmod: 	panic
depmod: 	blk_queue_headactive
depmod: 	free_pages
depmod: 	request_module
depmod: 	bh_task_vec
depmod: 	add_blkdev_randomness
depmod: 	proc_mkdir
depmod: 	del_timer
depmod: 	req_finished_io
depmod: 	remove_bh
depmod: 	blk_queue_bounce_limit
depmod: 	kfree
depmod: 	wait_for_completion
depmod: 	init_bh
depmod: 	remove_proc_entry
depmod: 	add_wait_queue
depmod: 	blk_init_queue
depmod: 	mem_map
depmod: 	blk_queue_throttle_sectors
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	__brelse
depmod: 	__tasklet_hi_schedule
depmod: 	daemonize
depmod: 	jiffies
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	blksize_size
depmod: 	ioport_resource
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/scsi/sd_mod.o
depmod: 	blk_ioctl
depmod: 	schedule_timeout
depmod: 	max_sectors
depmod: 	register_disk
depmod: 	check_disk_change
depmod: 	kmalloc
depmod: 	invalidate_device
depmod: 	devfs_register_partitions
depmod: 	unregister_blkdev
depmod: 	grok_partitions
depmod: 	register_blkdev
depmod: 	panic
depmod: 	del_gendisk
depmod: 	add_gendisk
depmod: 	kfree
depmod: 	blk_dev
depmod: 	read_ahead
depmod: 	sprintf
depmod: 	jiffies
depmod: 	printk
depmod: 	blksize_size
depmod: 	hardsect_size
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/scsi/sr_mod.o
depmod: 	blk_ioctl
depmod: 	_mmx_memcpy
depmod: 	check_disk_change
depmod: 	kmalloc
depmod: 	invalidate_device
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	panic
depmod: 	blk_size
depmod: 	kfree
depmod: 	blk_dev
depmod: 	read_ahead
depmod: 	sprintf
depmod: 	__invalidate_buffers
depmod: 	printk
depmod: 	irq_stat
depmod: 	blksize_size
depmod: 	hardsect_size
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/sound/ac97_codec.o
depmod: 	__get_user_4
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/sound/sound.o
depmod: 	remap_page_range
depmod: 	_mmx_memcpy
depmod: 	__get_user_1
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	isa_dma_bridge_buggy
depmod: 	free_dma
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	no_llseek
depmod: 	panic
depmod: 	free_pages
depmod: 	interruptible_sleep_on_timeout
depmod: 	request_module
depmod: 	request_dma
depmod: 	del_timer
depmod: 	interruptible_sleep_on
depmod: 	__pollwait
depmod: 	mem_map
depmod: 	sprintf
depmod: 	jiffies
depmod: 	__vmalloc
depmod: 	printk
depmod: 	add_timer
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/sound/soundcore.o
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	vfree
depmod: 	try_inc_mod_count
depmod: 	sys_close
depmod: 	request_module
depmod: 	kfree
depmod: 	sprintf
depmod: 	__vmalloc
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/sound/via82cxxx_audio.o
depmod: 	pci_write_config_byte
depmod: 	pci_set_power_state
depmod: 	__down_failed_trylock
depmod: 	pci_dev_driver
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	pci_register_driver
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	__down_failed_interruptible
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	pci_read_config_byte
depmod: 	pci_disable_device
depmod: 	no_llseek
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	pci_alloc_consistent
depmod: 	__pollwait
depmod: 	pci_release_regions
depmod: 	kfree
depmod: 	pci_devices
depmod: 	request_irq
depmod: 	pci_unregister_driver
depmod: 	add_wait_queue
depmod: 	pci_set_master
depmod: 	mem_map
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__generic_copy_to_user
depmod: 	pci_request_regions
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/hid.o
depmod: 	_mmx_memcpy
depmod: 	kmalloc
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/host/ehci-hcd.o
depmod: 	schedule_timeout
depmod: 	pci_register_driver
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	pci_read_config_byte
depmod: 	pci_pool_free
depmod: 	pci_read_config_dword
depmod: 	pci_alloc_consistent
depmod: 	pci_pool_alloc
depmod: 	del_timer
depmod: 	mod_timer
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	pci_pool_destroy
depmod: 	unregister_reboot_notifier
depmod: 	pci_pool_create
depmod: 	pci_unregister_driver
depmod: 	pci_write_config_dword
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	__const_udelay
depmod: 	pci_set_mwi
depmod: 	register_reboot_notifier
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/host/uhci.o
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	pci_register_driver
depmod: 	kmem_cache_free
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	pci_enable_device
depmod: 	create_proc_entry
depmod: 	free_irq
depmod: 	pci_pool_free
depmod: 	__out_of_line_bug
depmod: 	pci_alloc_consistent
depmod: 	kmem_cache_create
depmod: 	pci_pool_alloc
depmod: 	del_timer
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	pci_pool_destroy
depmod: 	remove_proc_entry
depmod: 	request_irq
depmod: 	pci_pool_create
depmod: 	pci_unregister_driver
depmod: 	pci_set_master
depmod: 	pci_write_config_word
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	jiffies
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	kmem_cache_alloc
depmod: 	__generic_copy_to_user
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/host/usb-ohci.o
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	pci_register_driver
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	pci_free_consistent
depmod: 	pci_enable_device
depmod: 	pci_disable_device
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	pci_pool_free
depmod: 	__out_of_line_bug
depmod: 	iounmap
depmod: 	pci_alloc_consistent
depmod: 	__ioremap
depmod: 	pci_pool_alloc
depmod: 	del_timer
depmod: 	iomem_resource
depmod: 	kfree
depmod: 	pci_pool_destroy
depmod: 	pci_find_slot
depmod: 	request_irq
depmod: 	pci_pool_create
depmod: 	pci_unregister_driver
depmod: 	add_wait_queue
depmod: 	pci_set_master
depmod: 	sprintf
depmod: 	jiffies
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/storage/usb-storage.o
depmod: 	flush_signals
depmod: 	_mmx_memcpy
depmod: 	schedule_timeout
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	reparent_to_init
depmod: 	complete
depmod: 	init_task_union
depmod: 	kfree
depmod: 	wait_for_completion
depmod: 	exit_files
depmod: 	sprintf
depmod: 	daemonize
depmod: 	printk
depmod: 	irq_stat
depmod: 	kernel_thread
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/usbcore.o
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	__generic_copy_from_user
depmod: 	schedule
depmod: 	__release_region
depmod: 	unlock_new_inode
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	proc_bus
depmod: 	__get_free_pages
depmod: 	reparent_to_init
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	send_sig_info
depmod: 	complete
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	try_inc_mod_count
depmod: 	kill_proc
depmod: 	d_rehash
depmod: 	__out_of_line_bug
depmod: 	iounmap
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	__ioremap
depmod: 	proc_mkdir
depmod: 	d_alloc_root
depmod: 	del_timer
depmod: 	__pollwait
depmod: 	iomem_resource
depmod: 	kfree
depmod: 	wait_for_completion
depmod: 	remove_proc_entry
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	request_irq
depmod: 	schedule_task
depmod: 	add_wait_queue
depmod: 	pci_set_master
depmod: 	xtime
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	daemonize
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	strtok
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	complete_and_exit
depmod: 	irq_stat
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	rwsem_down_read_failed
depmod: 	__generic_copy_to_user
depmod: 	iget4_locked
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/usbkbd.o
depmod: 	kmalloc
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/drivers/usb/usbmouse.o
depmod: 	kmalloc
depmod: 	kfree
depmod: 	sprintf
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/binfmt_aout.o
depmod: 	send_sig
depmod: 	__get_user_1
depmod: 	dump_thread
depmod: 	setup_arg_pages
depmod: 	compute_creds
depmod: 	do_brk
depmod: 	__set_personality
depmod: 	register_binfmt
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	do_mmap_pgoff
depmod: 	kernel_read
depmod: 	jiffies
depmod: 	flush_old_exec
depmod: 	unregister_binfmt
depmod: 	printk
depmod: 	set_binfmt
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/binfmt_misc.o
depmod: 	dput
depmod: 	prepare_binprm
depmod: 	d_alloc
depmod: 	__generic_copy_from_user
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	_ctype
depmod: 	__up_wakeup
depmod: 	__get_free_pages
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	force_delete
depmod: 	__mntput
depmod: 	d_rehash
depmod: 	__out_of_line_bug
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	d_alloc_root
depmod: 	register_binfmt
depmod: 	kfree
depmod: 	lookup_one_len
depmod: 	open_exec
depmod: 	search_binary_handler
depmod: 	fput
depmod: 	xtime
depmod: 	simple_strtoul
depmod: 	kern_mount
depmod: 	copy_strings_kernel
depmod: 	sprintf
depmod: 	d_instantiate
depmod: 	unregister_binfmt
depmod: 	remove_arg_zero
depmod: 	__generic_copy_to_user
depmod: 	dcache_dir_ops
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/ext3/ext3.o
depmod: 	inode_setattr
depmod: 	dput
depmod: 	__down_failed_trylock
depmod: 	_mmx_memcpy
depmod: 	__get_user_4
depmod: 	buffer_insert_list
depmod: 	in_group_p
depmod: 	init_special_inode
depmod: 	generic_file_llseek
depmod: 	unlock_buffer
depmod: 	update_atime
depmod: 	block_prepare_write
depmod: 	generic_file_write
depmod: 	vsprintf
depmod: 	unlock_page
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	fsync_no_super
depmod: 	blkdev_put
depmod: 	__mark_inode_dirty
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	fs_overflowuid
depmod: 	block_read_full_page
depmod: 	bread
depmod: 	getblk
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	panic
depmod: 	get_random_bytes
depmod: 	ll_rw_block
depmod: 	bdget
depmod: 	generic_file_read
depmod: 	fs_overflowgid
depmod: 	create_empty_buffers
depmod: 	register_filesystem
depmod: 	block_sync_page
depmod: 	zone_table
depmod: 	d_alloc_root
depmod: 	__mark_buffer_dirty
depmod: 	page_symlink_inode_operations
depmod: 	is_read_only
depmod: 	get_hash_table
depmod: 	event
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	blkdev_get
depmod: 	fsync_buffers_list
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	find_or_create_page
depmod: 	vfs_follow_link
depmod: 	set_blocksize
depmod: 	xtime
depmod: 	simple_strtoul
depmod: 	__invalidate_buffers
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	insert_inode_hash
depmod: 	block_symlink
depmod: 	block_write_full_page
depmod: 	__free_pages
depmod: 	strtok
depmod: 	inode_change_ok
depmod: 	printk
depmod: 	rwsem_down_read_failed
depmod: 	iget4_locked
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: 	hardsect_size
depmod: 	bdevname
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/fat/fat.o
depmod: 	inode_setattr
depmod: 	_mmx_memcpy
depmod: 	__get_user_2
depmod: 	generic_file_llseek
depmod: 	load_nls
depmod: 	generic_file_write
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	kdevname
depmod: 	__up_wakeup
depmod: 	load_nls_default
depmod: 	__get_free_pages
depmod: 	__mark_inode_dirty
depmod: 	file_fsync
depmod: 	iput
depmod: 	block_read_full_page
depmod: 	bread
depmod: 	getblk
depmod: 	dget_locked
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	make_bad_inode
depmod: 	ll_rw_block
depmod: 	generic_file_read
depmod: 	free_pages
depmod: 	block_sync_page
depmod: 	request_module
depmod: 	cont_prepare_write
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	sys_tz
depmod: 	event
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	iunique
depmod: 	utf8_wcstombs
depmod: 	set_blocksize
depmod: 	xtime
depmod: 	igrab
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	__brelse
depmod: 	insert_inode_hash
depmod: 	block_write_full_page
depmod: 	strtok
depmod: 	inode_change_ok
depmod: 	printk
depmod: 	__generic_copy_to_user
depmod: 	iget4_locked
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: 	hardsect_size
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/isofs/isofs.o
depmod: 	_mmx_memcpy
depmod: 	init_special_inode
depmod: 	load_nls
depmod: 	unlock_page
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	generic_read_dir
depmod: 	kdevname
depmod: 	_ctype
depmod: 	load_nls_default
depmod: 	__get_free_pages
depmod: 	utf8_wctomb
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	block_read_full_page
depmod: 	bread
depmod: 	getblk
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	panic
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	block_sync_page
depmod: 	zone_table
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	kfree
depmod: 	set_blocksize
depmod: 	_alloc_pages
depmod: 	generic_ro_fops
depmod: 	simple_strtoul
depmod: 	ioctl_by_bdev
depmod: 	sprintf
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	__free_pages
depmod: 	strtok
depmod: 	printk
depmod: 	strnicmp
depmod: 	iget4_locked
depmod: 	generic_block_bmap
depmod: 	hardsect_size
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/jbd/jbd.o
depmod: 	_mmx_memcpy
depmod: 	yield
depmod: 	__wake_up
depmod: 	put_unused_buffer_head
depmod: 	kmem_cache_free
depmod: 	schedule
depmod: 	unlock_buffer
depmod: 	kmalloc
depmod: 	bmap
depmod: 	kdevname
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	get_unused_buffer_head
depmod: 	fsync_no_super
depmod: 	reparent_to_init
depmod: 	iput
depmod: 	sleep_on
depmod: 	remove_wait_queue
depmod: 	getblk
depmod: 	ll_rw_block
depmod: 	submit_bh
depmod: 	zone_table
depmod: 	kmem_cache_create
depmod: 	set_bh_page
depmod: 	del_timer
depmod: 	get_hash_table
depmod: 	interruptible_sleep_on
depmod: 	mark_buffer_dirty
depmod: 	refile_buffer
depmod: 	kfree
depmod: 	try_to_free_buffers
depmod: 	__run_task_queue
depmod: 	tq_disk
depmod: 	__bforget
depmod: 	add_wait_queue
depmod: 	mem_map
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	daemonize
depmod: 	jiffies
depmod: 	wake_up_process
depmod: 	printk
depmod: 	add_timer
depmod: 	set_buffer_flushtime
depmod: 	kernel_thread
depmod: 	kmem_cache_alloc
depmod: 	init_buffer
depmod: 	__down_failed
depmod: 	bdevname
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/msdos/msdos.o
depmod: 	__mark_inode_dirty
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	d_rehash
depmod: 	register_filesystem
depmod: 	event
depmod: 	xtime
depmod: 	d_instantiate
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_cp1250.o
depmod: 	register_nls
depmod: 	unregister_nls
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_cp437.o
depmod: 	register_nls
depmod: 	unregister_nls
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_cp850.o
depmod: 	register_nls
depmod: 	unregister_nls
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_cp852.o
depmod: 	register_nls
depmod: 	unregister_nls
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_iso8859-1.o
depmod: 	register_nls
depmod: 	unregister_nls
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_iso8859-2.o
depmod: 	register_nls
depmod: 	unregister_nls
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/nls/nls_utf8.o
depmod: 	register_nls
depmod: 	utf8_wctomb
depmod: 	unregister_nls
depmod: 	utf8_mbtowc
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/ntfs/ntfs.o
depmod: 	_mmx_memcpy
depmod: 	generic_file_llseek
depmod: 	load_nls
depmod: 	schedule
depmod: 	unlock_buffer
depmod: 	vsprintf
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	generic_read_dir
depmod: 	__wait_on_buffer
depmod: 	load_nls_default
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	bread
depmod: 	high_memory
depmod: 	d_rehash
depmod: 	ll_rw_block
depmod: 	generic_file_open
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	__bforget
depmod: 	set_blocksize
depmod: 	xtime
depmod: 	simple_strtoul
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	num_physpages
depmod: 	__vmalloc
depmod: 	strtok
depmod: 	printk
depmod: 	__generic_copy_to_user
depmod: 	iget4_locked
depmod: 	hardsect_size
depmod: 	bdevname
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/romfs/romfs.o
depmod: 	_mmx_memcpy
depmod: 	init_special_inode
depmod: 	unlock_page
depmod: 	unlock_new_inode
depmod: 	generic_read_dir
depmod: 	kdevname
depmod: 	unregister_filesystem
depmod: 	bread
depmod: 	d_rehash
depmod: 	register_filesystem
depmod: 	zone_table
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	set_blocksize
depmod: 	generic_ro_fops
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	__free_pages
depmod: 	printk
depmod: 	iget4_locked
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/fs/vfat/vfat.o
depmod: 	dput
depmod: 	_mmx_memcpy
depmod: 	d_invalidate
depmod: 	kmalloc
depmod: 	_ctype
depmod: 	__get_free_pages
depmod: 	__mark_inode_dirty
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	d_find_alias
depmod: 	d_rehash
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	event
depmod: 	kfree
depmod: 	utf8_mbstowcs
depmod: 	xtime
depmod: 	sprintf
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	strtok
depmod: 	printk
depmod: 	strnicmp
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/lib/zlib_deflate/zlib_deflate.o
depmod: 	_mmx_memcpy
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/lib/zlib_inflate/zlib_inflate.o
depmod: 	_mmx_memcpy
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod: 	ip_send_check
depmod: 	nf_unregister_hook
depmod: 	sock_wfree
depmod: 	__kfree_skb
depmod: 	kmem_cache_free
depmod: 	schedule
depmod: 	kmalloc
depmod: 	skb_linearize
depmod: 	ip_defrag
depmod: 	create_proc_entry
depmod: 	vfree
depmod: 	nf_unregister_sockopt
depmod: 	get_random_bytes
depmod: 	kmem_cache_create
depmod: 	ip_ct_attach
depmod: 	proc_dointvec
depmod: 	unregister_sysctl_table
depmod: 	del_timer
depmod: 	net_ratelimit
depmod: 	ip_fragment
depmod: 	sk_free
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	nf_register_hook
depmod: 	csum_partial
depmod: 	proc_net
depmod: 	nf_register_sockopt
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	jiffies
depmod: 	num_physpages
depmod: 	__vmalloc
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	register_sysctl_table
depmod: 	kmem_cache_alloc
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o
depmod: 	_ctype
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	strnicmp
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ip_conntrack_irc.o
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ip_nat_ftp.o
depmod: 	net_ratelimit
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ip_nat_irc.o
depmod: 	net_ratelimit
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ip_tables.o
depmod: 	_mmx_memcpy
depmod: 	__generic_copy_from_user
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	vfree
depmod: 	nf_unregister_sockopt
depmod: 	request_module
depmod: 	net_ratelimit
depmod: 	remove_proc_entry
depmod: 	proc_net
depmod: 	nf_register_sockopt
depmod: 	sprintf
depmod: 	num_physpages
depmod: 	__vmalloc
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	__generic_copy_to_user
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_LOG.o
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_MASQUERADE.o
depmod: 	unregister_netdevice_notifier
depmod: 	unregister_inetaddr_notifier
depmod: 	ip_route_output_key
depmod: 	register_inetaddr_notifier
depmod: 	register_netdevice_notifier
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_REJECT.o
depmod: 	__ip_select_ident
depmod: 	_mmx_memcpy
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	ip_finish_output
depmod: 	nf_hooks
depmod: 	ip_route_output_key
depmod: 	__out_of_line_bug
depmod: 	ip_route_input
depmod: 	ip_ct_attach
depmod: 	___pskb_trim
depmod: 	xrlim_allow
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	printk
depmod: 	nf_hook_slow
depmod: 	skb_copy_expand
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_TCPMSS.o
depmod: 	__kfree_skb
depmod: 	skb_copy
depmod: 	__out_of_line_bug
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	printk
depmod: 	skb_copy_expand
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_ULOG.o
depmod: 	_mmx_memcpy
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	netlink_kernel_create
depmod: 	__out_of_line_bug
depmod: 	netlink_broadcast
depmod: 	del_timer
depmod: 	net_ratelimit
depmod: 	skb_over_panic
depmod: 	sock_release
depmod: 	jiffies
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_conntrack.o
depmod: 	jiffies
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_helper.o
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_limit.o
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_mac.o
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_ttl.o
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/ipt_unclean.o
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/iptable_filter.o
depmod: 	nf_unregister_hook
depmod: 	net_ratelimit
depmod: 	nf_register_hook
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/iptable_mangle.o
depmod: 	nf_unregister_hook
depmod: 	ip_route_me_harder
depmod: 	net_ratelimit
depmod: 	nf_register_hook
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.4.22-pre10-ac1/kernel/net/ipv4/netfilter/iptable_nat.o
depmod: 	ip_send_check
depmod: 	nf_unregister_hook
depmod: 	sock_wfree
depmod: 	_mmx_memcpy
depmod: 	__kfree_skb
depmod: 	ip_route_me_harder
depmod: 	ip_route_output_key
depmod: 	vfree
depmod: 	skb_copy
depmod: 	__out_of_line_bug
depmod: 	request_module
depmod: 	net_ratelimit
depmod: 	___pskb_trim
depmod: 	nf_register_hook
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	sprintf
depmod: 	__vmalloc
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	skb_copy_expand
make: *** [_modinst_post] B³±d 1

My .config is:

# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IKCONFIG=y
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
# CONFIG_ACPI_THERMAL is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_RELAXED_AML is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_DM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
CONFIG_IP_NF_MATCH_TTL=m
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_TOS is not set
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
# CONFIG_IP_NF_TARGET_MARK is not set
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_EDP2 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_IDE_CHIPSETS=y
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
# CONFIG_CHR_DEV_SG is not set
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_ATA is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
CONFIG_HP100=m
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_ATI is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_S3 is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_AD1889 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_KAHLUA is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
CONFIG_SOUND_TVMIXER=m
# CONFIG_SOUND_AD1980 is not set
# CONFIG_SOUND_WM97XX is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_PANIC_MORSE=y
# CONFIG_DEBUG_SPINLOCK is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
# CONFIG_FW_LOADER is not set
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
