Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWI1UsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWI1UsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWI1UsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:48:12 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:21188 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750784AbWI1UsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:48:11 -0400
Date: Thu, 28 Sep 2006 16:48:09 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
In-Reply-To: <451C33B2.5000007@goop.org>
Message-ID: <Pine.LNX.4.64.0609281647030.28756@d.namei>
References: <451C33B2.5000007@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Jeremy Fitzhardinge wrote:

> BUG: unable to handle kernel paging request at virtual address 756e6547
> printing eip:
> f898bf73
> *pde = 0014c7c0
> Oops: 0002 [#1]
> SMP last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> Modules linked in: ath_pci(U) usb_storage loop wlan_wep(U) snd_hda_codec nfsd
> exportfs lockd nfs_acl tun ppp_deflate zlib_deflate ppp_async crc_ccitt
> ppp_generic slhc airprime usbserial hci_usb cpufreq_powersave i915 drm
> cpufreq_conservative ipv6 autofs4 hidp rfcomm l2cap bluetooth sunrpc
> ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables
> x_tables vfat fat dm_mirror dm_mod video sbs ibm_acpi i2c_ec dock button
> battery asus_acpi ac parport_pc lp parport snd_seq_dummy snd_seq_oss
> snd_seq_midi_event snd_seq wlan_scan_sta(U) snd_seq_device snd_pcm_oss
> snd_mixer_oss snd_pcm ath_rate_sample(U) mmc_block snd_timer snd sg ohci1394
> i2c_i801 wlan(U) ieee1394 sdhci soundcore pcspkr i2c_core snd_page_alloc
> serio_raw e1000 mmc_core ath_hal(U) ahci libata sd_mod scsi_mod ext3 jbd
> ehci_hcd ohci_hcd uhci_hcd
> CPU:    0
> EIP:    0060:[<f898bf73>]    Tainted: P      VLI

Seems that one of the modules tainted the kernel.  Any idea which?


-- 
James Morris
<jmorris@namei.org>
