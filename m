Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVHII52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVHII52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 04:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVHII52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 04:57:28 -0400
Received: from pop.gmx.de ([213.165.64.20]:30616 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932469AbVHII51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 04:57:27 -0400
X-Authenticated: #6656014
From: Hans-Christian Armingeon <mog.johnny@gmx.net>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: irqpoll causing some breakage?
Date: Tue, 9 Aug 2005 10:57:19 +0200
User-Agent: KMail/1.8.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <42F7FD5E.6000107@gentoo.org>
In-Reply-To: <42F7FD5E.6000107@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508091057.22712.mog.johnny@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 09 August 2005 02:48 schrieb Daniel Drake:
> Hi,
> 
> I recently added the irqpoll patch to Gentoo's 2.6.12 kernels, using this patch:
> 
> http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/2700_irqpoll.patch
> 
> Since then, I've had a few reports of minor breakage, but this is the first 
> one I've been able to get full info on.
> 
> Hans-Christian Armingeon (on CC) owns a a combined USB keyboard-mouse, which 
> is broken when the irqpoll patch is applied.
> 
> input: USB HID v1.00 Keyboard [Cherry GmbH Cherry Slim Line Trackball 
> Keyboard] on usb-0000:00:10.0-1
> input: USB HID v1.00 Mouse [Cherry GmbH Cherry Slim Line Trackball Keyboard] 
> on usb-0000:00:10.0-1
> 
> After the irqpoll patch has been applied, the mouse does not work (the 
> keyboard works fine..!). This is without the irqpoll/irqfixup parameters, 
> although adding them does not help either. No errors appear, as far as I can see.

I have two other mice, and they don't work, too.

My usb Setup_

PortA --- Keyboard with integrated mouse
PortB --- Hub
HubPortA --- Mouse
HubPortA --- Trackball

The mice don't work, when I plug them directly into Port A or B .

The keyboard works ervery time.

> 
> The problem also exists in an unpatched 2.6.13_rc6.
> 
> dmesg here: https://bugs.gentoo.org/attachment.cgi?id=65470
> full bug: https://bugs.gentoo.org/show_bug.cgi?id=101463
> 
> I realise that this is probably not enough information to make any sense out 
> of! Please let me know how we can help further.

Me too.

> 
> Thanks,
> Daniel
> 
> 

Thanks in advance,

Johnny
