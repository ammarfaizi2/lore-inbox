Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVGBHW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVGBHW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 03:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVGBHW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 03:22:27 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:35463 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261832AbVGBHWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 03:22:22 -0400
Message-ID: <42C640AC.1020602@free.fr>
Date: Sat, 02 Jul 2005 09:22:20 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS +
 empty /dev
References: <42C30CBC.5030704@free.fr> <20050629224040.GB18462@kroah.com> <1120137161.42c3efc93b36c@imp1-q.free.fr> <20050630155453.GA6828@kroah.com> <42C455C1.30503@free.fr> <20050702053711.GA5635@kroah.com>
In-Reply-To: <20050702053711.GA5635@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Why?  Why not put it in ROM with your kernel image, look at how the
> kernel build process does it with the "built-in" initramfs.

Well, nowadays, most system have only flash because ROM does not enable
to do firmware upgrade. Second, putting it in the kernel or as a
separate flash section or in an initrd does not change the problem :
something has to be stored on non volatile memory whereas you do not
need that for devfs (except devfs code itself of course) but then you
have udev instead of devfs...

> I boot my boxes with nothing in /dev and have been for almost a year
> now.  udev works just fine for this, and so do some other programs that
> work like udev does.

Nothing in /dev but with initramfs. Same cost...

BTW : valette@tri-yann->df /dev
Filesystem           1K-blocks      Used Available Use% Mounted on
tmpfs                    10240      2876      7364  29% /dev


2 MB RAM on my PC???  I must be missing something.

Thanks for your time nayway.

-- eric

