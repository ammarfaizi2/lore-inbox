Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUKKTDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUKKTDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUKKTDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:03:54 -0500
Received: from mail.epost.de ([193.28.100.151]:63644 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id S262293AbUKKTDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:03:53 -0500
From: Gregor Jasny <Gregor.Jasny@epost.de>
To: linux-kernel@vger.kernel.org
Subject: USB-1.1 fails with USB 2.0 Hub [was: Re: USB-Serial fails with USB 2.0 Hub]
Date: Thu, 11 Nov 2004 20:03:43 +0100
User-Agent: KMail/1.7
References: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
In-Reply-To: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411112003.43598.Gregor.Jasny@epost.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 November 2004 16:49, you wrote:
> Two problems with kernel 2.6.4 (SuSe 9.1):
>
> 1) When I use a Belkin F5U409 usb-serial converter:
>      - when plugged directly into chipset (Intel ICH5), works great.
>      - when plugged in through a USB 1.0 hub, works great
>      - when plugged in throught USB 2.0 Hub (Belkin F5U237), fails.
>        Failure mechanism is: Tx works, Rx does not.

Just a simple me, too. I've got the problem with a TerraCAM USB Pro. Plugged 
into my Apple Keyboard it works (with a warning about high power 
consumption). But if I plug it into my Belkin F5U237 the driver complains 
with: "drivers/usb/media/ov511.c: init isoc: usb_submit_urb(0) ret -38".

Have you already tried another USBv2 hub?

Cheers,
-Gregor

PS: I'm using a ASUS P4C800deluxe and Linux 2.6.9
