Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVKVH2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVKVH2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKVH2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:28:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:15755 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932181AbVKVH2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:28:50 -0500
Date: Mon, 21 Nov 2005 23:28:30 -0800
From: Greg KH <greg@kroah.com>
To: gmishkin@bu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.2 kernel oops, looks acpi-related
Message-ID: <20051122072830.GB25419@kroah.com>
References: <200511212050.10671.gmishkin@acs.bu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511212050.10671.gmishkin@acs.bu.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 08:50:03PM -0500, Geoff Mishkin wrote:
> Unable to handle kernel paging request at virtual address 4b87ad6e
>  printing eip:
> c01f6b76
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: uhci_hcd ehci_hcd vmnet parport_pc parport vmmon arc4 
> ieee80211_crypt_wep ieee80211_crypt nfs lockd sunrpc cisco_ipsec ipt_state 
> iptable_filter iptable_nat ip_nat ip_conntrack iptable_mangle ip_tables 
> pcmcia yenta_socket rsrc_nonstatic pcmcia_core snd_pcm_oss snd_mixer_oss 
> snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
> snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore 
> snd_page_alloc nls_iso8859_1 ntfs nls_base nvram usbhid usb_storage usbcore 
> tun e1000 evdev fglrx intel_agp agpgart rtc speedstep_centrino freq_table 
> ibm_acpi
> CPU:    0
> EIP:    0060:[<c01f6b76>]    Tainted: P   M  VLI

Unfortunatly you have loaded the vmware drivers into your kernel, so we
really can't help out much here.  If you can duplicate this without
those drivers loaded, please file a bug at bugzilla.kernel.org.

thanks,

greg k-h
