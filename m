Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310172AbSCKP75>; Mon, 11 Mar 2002 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310174AbSCKP7r>; Mon, 11 Mar 2002 10:59:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61314 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310172AbSCKP7i>; Mon, 11 Mar 2002 10:59:38 -0500
Date: Mon, 11 Mar 2002 11:01:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: IDE on linux-2.4.18
Message-ID: <Pine.LNX.3.95.1020311110057.2492A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello IDE gurus,

I tried to install Linux-2.4.18 on a machine with IDE drives.
The machine ran fine with Linux-2.4.1. It won't mount the
root file-system because:

hda:	Cannot handle device with more than 16 heads giving up.

That's a real nice help. The device has 1024 cylinders, 255 heads
and 63 sectors. This is 6,422 MB. An attempt to set 16 heads in
the BIOS will allow access to only 528 MB, which is wrong.

So what is the magic incantation necessary to get the IDE
subsystem to work like it used to?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?

