Return-Path: <linux-kernel-owner+w=401wt.eu-S1762521AbWLJTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762521AbWLJTTV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762528AbWLJTTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:19:21 -0500
Received: from mail.pxnet.com ([195.227.45.3]:51612 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762522AbWLJTTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:19:19 -0500
Date: Sun, 10 Dec 2006 20:19:05 +0100
From: Tilman Schmidt <tilman@imap.cc>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial driver
CC: linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <20061210201438.tilman@imap.cc>
In-Reply-To: <4533B8FB.5080108@mvista.com>
References: <4533B8FB.5080108@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 11:53:15 -0500, Corey Minyard <cminyard@mvista.com> wrote:
> This is a set of three patches to allow adding another driver on top of
> the current serial driver without too much change to the serial code.
> This is more for comments right now, it is probably not ready for real
> use yet.
> 
> The patches are too big to post here, so I'm putting them on
> http://home.comcast.net/~minyard
> 
> The three patches are:
> 
>     * serial-remove-tty-struct-from-driver.patch - A general patch to
>       remove the tty includes from the low-level serial drivers. Only
>       fixes the 8250 for now.
> 
>     * serial-allow-in-kernel-users.patch - The actual patch that adds
>       the layered driver to the serial core.
> 
>     * serial-8250-cleanup.patch - Add support for the layered driver
>       and poll to the 8250 uart.

Has anything ever come of this? I would be very much interested in it.
It might make it possible to extend the Siemens Gigaset drivers
(drivers/isdn/gigaset) to the RS232 attached M101 DECT adapter.
There is a working driver out of tree which accesses the serial port
hardware directly (i8250 only), but that kind of thing doesn't seem
fit for inclusion in the kernel.

Thanks
Tilman

