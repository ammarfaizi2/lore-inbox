Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTKTEOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTKTEOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:14:43 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:39297
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261311AbTKTEOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:14:41 -0500
Date: Wed, 19 Nov 2003 23:12:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Sumit Pandya <sumit@elitecore.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, joern@wohnheim.fh-wedel.de
Subject: Re: Infinite do_IRQ
In-Reply-To: <005c01c3aeab$a0aa93c0$3901a8c0@elite.co.in>
Message-ID: <Pine.LNX.4.53.0311191032090.11537@montezuma.fsmlabs.com>
References: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in>
 <Pine.LNX.4.53.0311190332320.11537@montezuma.fsmlabs.com>
 <005c01c3aeab$a0aa93c0$3901a8c0@elite.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003, Sumit Pandya wrote:

> Hi Zwane,
>     I'm sorry to bother you again. Following is output from
> http://kernelnewbies.org/scripts/check-stack.sh

I think it'd really be easier to back out those patches one by one until 
your messages stop happening. Otherwise i'm not quite sure which one is 
really affecting you.

> 100 getxattr
> 100 pirq_peer_trick
> 100 removexattr
> 100 setxattr
> 100 sys_reboot
> 100 sys_recvmsg
> 108 rt_cache_get_info
> 108 sg_proc_hoststrs_info
> 10c rs_read_proc
> 110 autofs4_notify_daemon
> 110 set_serial_info
> 110 sys_sendmsg
> 114 scsi_request_sense
> 11c autofs4_expire_run
> 11c radeon_cp_clear
> 11c scan_scsis
> 128 aout_core_dump
> 13c load_elf_binary
> 140 do_execve
> 140 mmc_ioctl
> 140 vc_resize
> 144 elf_kcore_store_hdr
> 170 sg_ioctl
> 178 extract_entropy
> 190 sys_msgctl
> 1a0 scsi_reset_provider
> 1a4 sys_shmctl
> 1ac check_tcp_syn_cookie
> 1b0 tcp_timewait_state_process
> 1b4 ip_getsockopt
> 1cc secure_tcp_syn_cookie
> 1d0 tcp_v4_conn_request
> 1d4 sys_semtimedop
> 1d8 tcp_check_req
> 204 cdrom_buffer_sectors
> 224 cdrom_read_intr
> 228 ip_setsockopt
> 248 semctl_main
> 258 elf_core_dump
> 2a8 pci_do_scan_bus
> 2f4 vt_ioctl
> 31c sym53c8xx_detect
> 324 pcibios_fixup_peer_bridges
> 324 pci_sanity_check
> 410 cdrom_number_of_slots
> 410 cdrom_select_disc
> 410 cdrom_slot_status
> 444 cdrom_ioctl
> 47c ide_unregister
> 490 inflate_fixed
> 524 inflate_dynamic
> 5a8 huft_build
> 73c sanitize_e820_map
