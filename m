Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261957AbSI3Hxq>; Mon, 30 Sep 2002 03:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261965AbSI3Hxq>; Mon, 30 Sep 2002 03:53:46 -0400
Received: from mail.scram.de ([195.226.127.117]:43979 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261957AbSI3Hxp>;
	Mon, 30 Sep 2002 03:53:45 -0400
Date: Mon, 30 Sep 2002 09:59:07 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 compile errors on Alpha
In-Reply-To: <Pine.NEB.4.44.0209300934330.7633-100000@www2.scram.de>
Message-ID: <Pine.NEB.4.44.0209300950490.7633-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> these are the errors i found in my log from a "make -k modules" on Alpha:

Additionally, i got a couple of unresolved symbols at the end of the
compile (stripped those away with versioned symbols which are caused by a
dependent module which failed to compile):

depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/drivers/isdn/divert/dss1_divert.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/drivers/isdn/hardware/avm/b1pci.o
depmod:         b1pciv4_remove
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/drivers/isdn/hisax/hisax_fcclassic.o
depmod:         inb
depmod:         outb
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/drivers/isdn/isdnloop/isdnloop.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/drivers/usb/input/usbkbd.o
depmod:         usb_kbd_free_buffers
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/drivers/usb/storage/usb-storage.o
depmod:         ide_fix_driveid
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:         next_thread
depmod:         find_task_by_pid
depmod: *** Unresolved symbols in
/lib/modules/2.5.39/kernel/net/ipv6/netfilter/ip6t_owner.o
depmod:         next_thread
depmod:         find_task_by_pid
depmod: *** Unresolved symbols in /lib/modules/2.5.39/kernel/net/x25/x25.o
depmod:         sk_send_sigurg

Cheers,
--jochen

