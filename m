Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262954AbSJBDsU>; Tue, 1 Oct 2002 23:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbSJBDsT>; Tue, 1 Oct 2002 23:48:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17555 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262954AbSJBDsT>;
	Tue, 1 Oct 2002 23:48:19 -0400
Date: Tue, 1 Oct 2002 23:53:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: greg@kroah.com, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.39 + evms 1.2.0 burn test
In-Reply-To: <20021001.203131.48516382.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0210012349280.9782-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Oct 2002, David S. Miller wrote:

> sed 's/usb_kbd_free_buffers/usb_kbd_free_mem/' <usbkbd.c >usbkbd_fixed.c

's/usb_kbd_free_buffers/usb_kbd_free_mem/g', surely?

> mv usbkbd_fixed.c usbkbd.c
> make

Umm...  ed (ex, actually) scripts declared off-limits, so now it's sed, eh?

