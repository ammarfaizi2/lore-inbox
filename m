Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUBBG7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 01:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUBBG7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 01:59:14 -0500
Received: from pop.gmx.de ([213.165.64.20]:51173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265514AbUBBG7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 01:59:13 -0500
X-Authenticated: #222435
Date: Mon, 2 Feb 2004 07:59:44 +0100
From: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-Id: <20040202075944.522464db.diemer@gmx.de>
In-Reply-To: <20040202032514.GB20534@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de>
	<20040129230250.GA9988@kroah.com>
	<20040201215721.737ef5a3.diemer@gmx.de>
	<20040201212802.GA16301@kroah.com>
	<20040201230010.15874b4c.diemer@gmx.de>
	<20040202032514.GB20534@kroah.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004 19:25:14 -0800
Greg KH <greg@kroah.com> wrote:

> Yet you want to do asynchronous support with sysfs?  How would that
> work?
> What kind of device are you writing a driver for?

It is not firmware uploading only. Once the firmware is uploaded, I will
communicate with that device. It is a ezusb microcontroller controlling
several relais, adc and dac.


> For firmware only download type devices, I'd really recommend sticking
> with libusb, unless you have to.  It's much easier that way.

Yepp, there's already a tool using libusb (fx2 programmer) for my chip
which I indeed would use if I only wanted to download the firmware... 

regards
Jonas

PS: CC me.
