Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVBSVPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVBSVPP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 16:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVBSVPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 16:15:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261856AbVBSVOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 16:14:41 -0500
Subject: updated list of unused kernel exports posted
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 19 Feb 2005 22:14:33 +0100
Message-Id: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

an updated list of currently unused-on-i386 kernel exports is now posted
at http://www.kernel.org/pub/linux/kernel/people/arjan/unused based on
2.6.11-rc4-bk7.

Note 1) the URL of the location has changed; the previous URL led to
several vendors of binary modules to contact my employer in the hope to
pressure to get certain symbols off that list. This list has nothing to
do with my employer and as such I decided to move it to a more neutral
URL to not cause that incorrect burden.

Note 2) this list contains all unused symbols regardless of merit; it
contains pure bloating symbols but also symbols for emerging new
functionality not fully merged and generic library helpers.


The following symbols are added to this list since the last posted list;
some of these will be of the "emerging functionality" type, others will
be now-redundant and should be investigated for removal; after all each
exported symbol uses easily over a hundred bytes of unswappable kernel
memory for every linux user out there.

+++ unused.new  2005-02-19 21:27:59.556557390 +0100
+alloc_chrdev_region
+attribute_container_add_attrs
+attribute_container_add_class_device
+attribute_container_add_class_device_adapter
+attribute_container_class_device_del
+attribute_container_classdev_to_container
+attribute_container_device_trigger
+attribute_container_remove_attrs
+attribute_container_remove_device
+attribute_container_trigger
+backlight_device_register
+backlight_device_unregister
+class_device_create_bin_file
+class_device_remove_bin_file
+cpufreq_get
+cpufreq_parse_governor
+debugfs_create_bool
+debugfs_create_u16
+debugfs_create_u32
+debugfs_create_u8
+device_for_each_child
+fb_create_modedb
+fb_get_monitor_limits
+get_sb_pseudo
+hugetlb_total_pages
+ib_find_cached_gid
+kernel_subsys
+lcd_device_register
+lcd_device_unregister
+mt352_read
+nr_free_pages
+nr_pagecache
+nr_swap_pages
+pccard_static_ops
+phys_proc_id
+platform_get_irq_byname
+platform_get_resource_byname
+__scsi_print_sense
+scsi_sense_desc_find
+slab_reclaim_pages
+sysctl_overcommit_memory
+sysctl_overcommit_ratio
+totalram_pages
+total_swap_pages
+try_acquire_console_sem
+tveeprom_dump
+usb_bus_init
+vm_acct_memory
+vm_committed_space
+w1_search_devices
+wait_for_completion_interruptible
+wait_for_completion_interruptible_timeout
+wait_for_completion_timeout


