Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129672AbRAaXTC>; Wed, 31 Jan 2001 18:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129676AbRAaXSw>; Wed, 31 Jan 2001 18:18:52 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:28642 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129672AbRAaXSf>;
	Wed, 31 Jan 2001 18:18:35 -0500
Date: Thu, 1 Feb 2001 00:18:27 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101312318.AAA18543@harpo.it.uu.se>
To: jhigham@bigsky.net, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 - failed to exec /sbin/modprobe -s -k binfmt-464c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 14:17:56 -0700, Josh Higham wrote:

>I tried compiling a 2.2.18 kernel, and when I reboot I get
>
>failed to exec /sbin/modprobe -s -k binfmt-464c

Reconfigure with CONFIG_BINFMT_ELF=y and your kernel will work again.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
