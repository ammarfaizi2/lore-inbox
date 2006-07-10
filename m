Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWGJN0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWGJN0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWGJN0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:26:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16568 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964806AbWGJN0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:26:11 -0400
Subject: Re: [PATCH] Clean up old names in tty code to current names
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 14:43:54 +0100
Message-Id: <1152539034.27368.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 09:03 -0400, ysgrifennodd Jon Smirl:
> I agree with this. I made a mistake with the pts vs pty, why not just
> help me fix the mistake instead of rejecting everything? Some the of
> the info being reported in /proc/tty/drivers is wrong (vc./0 - from
> the devfs attempt?). or missing.

What are you trying to achieve and where are you trying to get. If you
want better info for the tty layer then get the new info working in
sysfs first. Then when people are generally using sysfs you can worry
about cleaning up/removing/breaking the old stuff.


> I'm not going to solve this problem but it is something that needs to
> be discussed. Are we really going to maintain parallel naming schemes,
> one in-kernel and one out of kernel? I'm not even sure if USB will
> work without udev anymore.

It works fine, it would not suprise me if udev users were still the
minority case in fact.

