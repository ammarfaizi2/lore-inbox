Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758219AbWLIDWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219AbWLIDWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 22:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbWLIDWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:22:08 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:35226 "EHLO
	liaag1aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758219AbWLIDWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:22:07 -0500
Date: Fri, 8 Dec 2006 22:19:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [stable] [patch 00/32] -stable review
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Message-ID: <200612082220_MC3-1-D468-A6F0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061209003810.GP1397@sequoia.sous-sol.org>

On Fri, 8 Dec 2006 16:38:10 -0800, Chris Wright wrote:

> And a roll-up is available at:
> 
>       http://www.kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc1.{gz,bz2}

Would it be possible to make this available as a quilt patchset, like this:

-rw-rw----  1 me me   267 Dec  8 21:59 00_version_2.6.19.1-pre1.patch
-rw-rw----  1 me me  2791 Dec  8 20:38 01_net_ipv6_ndisc_calc_pkt_length.patch
-rw-rw----  1 me me  2105 Dec  8 20:40 02_net_80211_softmac_tx_no_disable.patch
-rw-rw----  1 me me  3187 Dec  8 21:01 03_net_bridge_ebtables_fix_wraparound.patch
-rw-rw----  1 me me  2714 Dec  8 20:59 04_net_filter_ebtables_iterator_check_zero.patch
-rw-rw----  1 me me  1755 Dec  8 21:09 05_net_bridge_ebtables_loop_worst_case.patch
-rw-rw----  1 me me  3240 Dec  8 21:03 06_net_bridge_ebtables_fix_size_wrap.patch
-rw-rw----  1 me me  3277 Dec  8 20:48 07_net_sched_act_police_backwards_compat.patch
-rw-rw----  1 me me  1406 Dec  8 21:11 08_blk_cryptoloop_select_cbc.patch
-rw-rw----  1 me me  2992 Dec  8 20:36 09_acpi_revert_sci_override.patch
-rw-rw----  1 me me  1803 Dec  8 20:42 10_net_sched_gact_div_by_zero_fix.patch
-rw-rw----  1 me me  1729 Dec  8 20:54 11_net_sunhme_fix_x86_failure.patch
-rw-rw----  1 me me 11012 Dec  8 20:38 12_net_filter_fix_hook_validation.patch
-rw-rw----  1 me me  5334 Dec  8 21:10 13_net_filter_ipv4_fix_compat_validation.patch
-rw-rw----  1 me me  5325 Dec  8 21:12 14_net_filter_bridge_handle_martians.patch
-rw-rw----  1 me me  1944 Dec  8 21:07 15_net_80211_softmac_unbalanced_mutex.patch
-rw-rw----  1 me me  2126 Dec  8 20:43 16_drv_infiniband_cleanup_deadlock.patch
-rw-rw----  1 me me  2090 Dec  8 20:46 17_fs_exec_coredump_stop_rewrite.patch
-rw-rw----  1 me me  1883 Dec  8 20:55 18_net_tokenring_memory_corruption.patch
-rw-rw----  1 me me  2033 Dec  8 20:47 19_net_ipv4_use_output_dev_xfrm.patch
-rw-rw----  1 me me  1475 Dec  8 20:51 20_drv_usb_phidget_oops.patch
-rw-rw----  1 me me  1604 Dec  8 20:59 21_net_ipv4_xfrm_peer_leak.patch
-rw-rw----  1 me me  1889 Dec  8 21:02 22_net_irds_incorrect_ttp_hdr_reserv.patch
-rw-rw----  1 me me  1419 Dec  8 21:05 23_net_netlink_restore_compatibility.patch
-rw-rw----  1 me me  2970 Dec  8 21:06 24_separate_bh_declarations.patch
-rw-rw----  1 me me  1477 Dec  8 20:52 25_drv_drm_sis_linkage.patch
-rw-rw----  1 me me  3445 Dec  8 20:57 26_compat_mount_skip_null_data_page.patch
-rw-rw----  1 me me  1431 Dec  8 20:56 27_pm_swsusp_debug.patch
-rw-rw----  1 me me  4882 Dec  8 20:44 28_fs_autofs_fill_sb_error_code.patch
-rw-rw----  1 me me  2506 Dec  8 21:13 29_krnl_softirq_remove_bug_on.patch
-rw-rw----  1 me me  6657 Dec  8 20:49 30_m32r_make_userspace_hdrs.patch
-rw-rw----  1 me me  2472 Dec  8 20:41 31_x86_64_fix_nmi_init_hang.patch
-rw-rw----  1 me me  3016 Dec  8 20:53 32_net_drv_forcedeth_disable_intx.patch
-rw-rw----  1 me me  1279 Dec  8 22:01 series

It makes things much easier to review because I can use 'quilt annotate'
to find out which patch changed a line of source.

-- 
Chuck
"Even supernovas have their duller moments."
