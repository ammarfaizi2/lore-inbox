Return-Path: <linux-kernel-owner+w=401wt.eu-S1751303AbXANPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbXANPMi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 10:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbXANPMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 10:12:38 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:57845 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbXANPMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 10:12:38 -0500
X-Originating-Ip: 74.109.98.130
Date: Sun, 14 Jan 2007 09:59:43 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: icxcnika@mar.tar.cc
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.20-rc5
In-Reply-To: <Pine.LNX.4.64.0701141426220.12877@server.willdawg>
Message-ID: <Pine.LNX.4.64.0701140959170.792@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701141426220.12877@server.willdawg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2007, icxcnika@mar.tar.cc wrote:

> In compiling:
>   CC [M]  net/ipv4/netfilter/ipt_TTL.o
>   LD [M]  drivers/usb/storage/usb-storage.o
>   CC [M]  drivers/usb/gadget/net2280.o
>   CC [M]  net/ipv4/netfilter/arp_tables.o
> drivers/usb/gadget/net2280.c: In function 'net2280_probe':
> drivers/usb/gadget/net2280.c:2969: warning: ignoring return value of
> 'pci_set_mwi', declared with attribute warn_unused_result
> --
>   CC [M]  net/netfilter/xt_tcpmss.o
>   CC [M]  net/netfilter/xt_hashlimit.o
>   LD [M]  net/netfilter/nf_conntrack.o
>   Building modules, stage 2.
>   MODPOST 239 modules
> WARNING: "__ucmpdi2" [drivers/media/video/v4l2-common.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
>
> If a .config is needed or any other information, I'd be happy to provide it.

is this for a powerpc?  there's a thread you might want to read:

http://uwsg.iu.edu/hypermail/linux/kernel/0612.1/2162.html

rday
