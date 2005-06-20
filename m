Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFTN52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFTN52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVFTN52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:57:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50893 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261249AbVFTN5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:57:22 -0400
Date: Mon, 20 Jun 2005 19:24:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1: Kernel BUG at "fs/open.c":935
Message-ID: <20050620135435.GA4622@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050619233029.45dd66b8.akpm@osdl.org> <200506201521.12274.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506201521.12274.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 03:21:11PM +0200, Rafael J. Wysocki wrote:
> On Monday, 20 of June 2005 08:30, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> > 
> > 
> > - Someone broke /proc/device-tree on ppc64.  It's being looked into.
> > 
> > - Nothing particularly special here - various fixes and updates.
> 
> Unfortunately, it's broken with preempt on x86-64 (Athlon 64):
> 
> Kernel BUG at "fs/open.c":935
> invalid operand: 0000 [1] PREEMPT 
> CPU 0 
> Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
> Pid: 4269, comm: kded Not tainted 2.6.12-mm1
> RIP: 0010:[<ffffffff801a14fb>] <ffffffff801a14fb>{fd_install+187}

Could you please mail your .config ? I will take a look at this.

Thanks
Dipankar
