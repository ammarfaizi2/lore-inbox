Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUAZNqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 08:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUAZNqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 08:46:15 -0500
Received: from linux-bt.org ([217.160.111.169]:144 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262580AbUAZNqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 08:46:14 -0500
Subject: Re: Bluetooth USB oopses on unplug (2.6.1)
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Max Krasnyansky <maxk@qualcomm.com>
In-Reply-To: <20040126102041.GA1112@elf.ucw.cz>
References: <20040126102041.GA1112@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1075124726.25442.2.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 14:45:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> In 2.6.1, bluetooth-over-usb (hci_usb) works very well... As long as I
> do not unplug it. When I do, it oopses. Is there newer version of
> bluetooth that I should try?

try to disable the SCO audio option for the driver itself. It should
work then, because the driver no longer uses ISOC transfers.

However show us the oops (through ksymoops) and show us your USB
hardware on your motherboard (lspci).

Regards

Marcel


