Return-Path: <linux-kernel-owner+w=401wt.eu-S1762689AbWLKJea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762689AbWLKJea (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762691AbWLKJea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:34:30 -0500
Received: from gw-eur4.philips.com ([161.85.125.10]:54724 "EHLO
	gw-eur4.philips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762689AbWLKJe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:34:29 -0500
In-Reply-To: <200612081658.24194.a1426z@gawab.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: typo in init/initramfs.c
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF5010A572.F37D95B9-ONC1257241.0033BBE4-C1257241.0034922E@philips.com>
From: Jean-Paul Saman <jean-paul.saman@nxp.com>
Date: Mon, 11 Dec 2006 10:34:10 +0100
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF805 | August
 26, 2006) at 11/12/2006 10:34:12,
	Serialize complete at 11/12/2006 10:34:12
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel-owner@vger.kernel.org wrote on 08-12-2006 14:58:24:

> Jean-Paul Saman wrote:
> > linux-kernel-owner@vger.kernel.org wrote on 06-12-2006 19:17:27:
> > > Jean-Paul Saman wrote:
> > > > In populate_rootfs() the printk on line 554. It says "Unpacking
> > > > initramfs..", which is confusing because if that line is reached 
the
> > > > code has already decided that the image is an initrd image.
> > >
> > > Are you sure?
> >
> > Yes.
> 
> Are you really sure?
> 

Not anymore ;-) 

> Maybe you're getting confused with the dual intitrd naming-convention. 
> InitRD used to mean InitRamDisk only, now it means InitRamFS and 
InitRamDisk 
> #ifdef CONFIG_BLK_DEV_RAM, else it means InitRamFS only.

Well, I am confused. Reading drivers/block/Kconfig again and again I came 
to the conclusion that I've been misinterpreted what it said. The way the 
code is written is counter-intuitive, using INITRD for initramfs and 
initrd made my head go spinning.

> But still, it's rather refreshing to see you so convinced.

Thanks for your kind words.

Kind greetings,

Jean-Paul Saman

NXP Semiconductors CTO/RTG DesignIP

