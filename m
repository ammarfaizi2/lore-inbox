Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWC3QzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWC3QzP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWC3QzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:55:15 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:44733 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932222AbWC3QzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:55:13 -0500
Date: Thu, 30 Mar 2006 18:55:05 +0200
From: Voluspa <lista1@telia.com>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
       bjorn.helgaas@hp.com
Subject: Re: [2.6.16-gitX] PNP: No PS/2 controller found. Probing ports
 directly.
Message-Id: <20060330185505.798dfb7b.lista1@telia.com>
In-Reply-To: <d120d5000603300613o3e5db188p521b766be075dfdc@mail.gmail.com>
References: <20060330125523.2b713a96.lista1@telia.com>
	<d120d5000603300613o3e5db188p521b766be075dfdc@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006 09:13:30 -0500 Dmitry Torokhov wrote:
> On 3/30/06, Voluspa wrote:
> >
> > Due to the commit:
> >
> > 982c609448b9d724e1c3a0d5aeee388c064479f0 is first bad commit
> > diff-tree 982c609448b9d724e1c3a0d5aeee388c064479f0 (from 070c6999831dc4cfd9b07c74c2fea1964d7adfec)
> > Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > Date:   Mon Mar 27 01:17:08 2006 -0800
> >
> >    [PATCH] pnp: PNP: adjust pnp_register_driver signature
> >
> 
> Does it help if you apply this patch:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/dtor/input.git;a=commitdiff_plain;h=2bfc3c6e9516ece6856ec7904319650a5d4d9871;hp=dd55563f635751327eb06ae569d4761a0220f2e0

Perfect. No change in hardware function, no additional log messages and
I'm back at:

dmesg-5d4fe2c1ce83c3e967ccc1ba3d580c1a5603a866
[...]
io scheduler deadline registered
io scheduler cfq registered (default)
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
parport: PnPBIOS parport detected.

Mvh
Mats Johannesson
--
