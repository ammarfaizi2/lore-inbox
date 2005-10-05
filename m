Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbVJEPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVJEPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVJEPl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:41:58 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:11403
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S965220AbVJEPl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:41:58 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: umesh chandak <chandak_pict@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic error in 2.6.10
Date: Wed, 5 Oct 2005 11:41:58 -0400
Message-Id: <20051005153744.M67038@linuxwireless.org>
In-Reply-To: <20051005153314.94063.qmail@web35901.mail.mud.yahoo.com>
References: <20051005153314.94063.qmail@web35901.mail.mud.yahoo.com>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 15.235.153.98 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005 08:33:14 -0700 (PDT), umesh chandak wrote
> hi,
>          I have compiled the kernel 2.6.10 with KGDB
> patches on FC3 .My KGDB connetion are made correct .
> I have copied bzImage and System.map on test machine .
> but when i press C for continuig no devlopment m/c
> after  connection are made.It gives me kernel panic
> error like this
> 
> VFS: Cannot open root device "hda6" or
> unknown-block(3,6)
> Please append a correct "root=" boot option Kernel
> panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(3,6)
> 
> my root partion  is on /dev/hda6.
> My grub entry is like this.
> 
> title 2.6.10 kgdb
>          root (hd0,5)
>          kernel /boot/vmlinuz-2.6.0 ro root=/dev/hda6

2.6.0?

> rootfstype=ext3 kgdbwait kgdb8250=1,57600

