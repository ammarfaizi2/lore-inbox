Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRCEPz6>; Mon, 5 Mar 2001 10:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129394AbRCEPzu>; Mon, 5 Mar 2001 10:55:50 -0500
Received: from jalon.able.es ([212.97.163.2]:1415 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129388AbRCEPzd>;
	Mon, 5 Mar 2001 10:55:33 -0500
Date: Mon, 5 Mar 2001 16:55:02 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: usb-storage log verbosity
Message-ID: <20010305165502.A10344@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have recently started to use an USB cd toaster and have a little problem.
Writer is driven by usb-storage and scsi-cdrom and scsi-generic drivers.
Burning works fine.

The problem is that the usb-storage module spits so many info-debug
messages (even if I configured no debug in kernel config) that after
a cd burn I end up with a 25 MB file in /var/log/messages and other 25MB
in /var/log/kernel/info, so it fills my / partition.

If someone know a fast way to shut up usb-storage, I'll be gratefull.
If not, I will try to make a patch to enclose all that printk's into
#ifdef CONFIG_USB_STORAGE_DEBUG.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac11 #1 SMP Sat Mar 3 22:18:57 CET 2001 i686

