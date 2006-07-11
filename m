Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWGKV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWGKV6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWGKV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:58:41 -0400
Received: from ns1.suse.de ([195.135.220.2]:42949 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932166AbWGKV6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:58:40 -0400
Date: Tue, 11 Jul 2006 14:54:22 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Message-ID: <20060711215422.GB663@kroah.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com> <1152524657.27368.108.camel@localhost.localdomain> <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com> <1152537049.27368.119.camel@localhost.localdomain> <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com> <1152539034.27368.124.camel@localhost.localdomain> <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 10:07:41AM -0400, Jon Smirl wrote:
> >> I'm not going to solve this problem but it is something that needs to
> >> be discussed. Are we really going to maintain parallel naming schemes,
> >> one in-kernel and one out of kernel? I'm not even sure if USB will
> >> work without udev anymore.
> >
> >It works fine, it would not suprise me if udev users were still the
> >minority case in fact.

Well, as more modern distros spread, the number of users is getting
bigger..

> If I use udev to rename my devices, the names aren't going to match
> /proc/tty and what ps shows.

Same problem happens if you use 'mv'.  Are you going to blame the kernel
on that problem too?

> The idea behind udev is that the kernel only deals in device numbers
> and all naming happens in user space.

Please stop saying this, it is just not true at all, and never has been.

thanks,

greg k-h
