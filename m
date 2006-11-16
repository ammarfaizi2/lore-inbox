Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423943AbWKPMxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423943AbWKPMxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423941AbWKPMxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:53:02 -0500
Received: from raven.upol.cz ([158.194.120.4]:43474 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1423943AbWKPMxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:53:00 -0500
To: Heiko Gerstung <heiko.gerstung@meinberg.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Initial ramdisk support does not work (for me) on 2.6.17.13
In-Reply-To: <455AF068.5020700@meinberg.de>
References: <455AF068.5020700@meinberg.de>
Date: Thu, 16 Nov 2006 13:00:06 +0000
Message-Id: <E1Gkgqc-0003F3-6u@flower>
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
> Hi!

Hallo.

> We are building embedded devices based on Linux and we use a ramdisk as
> our root device in order to avoid problems with people switching off the
> unit without a proper shutdown and to save write-cycles on our flash disc.
>
> Using a 2.6.12 kernel it was no problem to boot the system by using this
> kernel parameters:
> load_ramdisk=1 console=tty0 initrd=initrd.gz rw  vga=769
> ramdisk_size=32768 root=/dev/ram0
>
> Today I tried to test run a 2.6.17.12 kernel using the same parameters
> but I get this error message:
> VFS: Cannot open root device "ram0" or unknown-block(1,0)
> Please append a correct "root=" boot option

In subject you've wrote "2.6.17.13", but anyway in such cases one must
include full dmesg (boot output) and (sometimes) ".config".

Also, if you are using some kind of embedded hardware, f.e. ARM,
please, use arm-user mailing list for such questions.
____
