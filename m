Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSKBXK0>; Sat, 2 Nov 2002 18:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSKBXKZ>; Sat, 2 Nov 2002 18:10:25 -0500
Received: from mail.scram.de ([195.226.127.117]:57033 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261531AbSKBXKZ>;
	Sat, 2 Nov 2002 18:10:25 -0500
Date: Sun, 3 Nov 2002 00:10:43 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Greg KH <greg@kroah.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] USB Kernel bug in 2.5.45
In-Reply-To: <20021102204419.GB22607@kroah.com>
Message-ID: <Pine.LNX.4.44.0211030010060.18761-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> If you disable devfs does it work ok?

Yes, it does...

drivers/usb/core/usb.c: deregistering driver hiddev
drivers/usb/core/usb.c: deregistering driver hid

and the module is gone.

--jochen

