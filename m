Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTHGPqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHGPpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:45:43 -0400
Received: from port-212-202-27-44.reverse.qsc.de ([212.202.27.44]:60717 "EHLO
	camelot.fbunet.de") by vger.kernel.org with ESMTP id S270208AbTHGPpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:45:07 -0400
From: Fridtjof Busse <fbusse@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc1
Date: Thu, 7 Aug 2003 17:45:06 +0200
References: <Pine.LNX.4.53.0308071119200.27424@mx.homelinux.com> <15050.1060270543@www56.gmx.net>
In-Reply-To: <15050.1060270543@www56.gmx.net>
Cc: Mitch@0Bits.COM
X-OS: Linux on i686
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071745.06074@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* <Mitch@0Bits.COM>:
> Not enough info.
>
> What usb controller do you have ? Which usb driver ?
> ohci ? uhci ? ehci ? usb 2.0 ?

nforce2 with the ehci-driver.

> I reported this a long time ago on the usb lists, but
> never got down to the bottom of the problem (my fault for
> not following thru). 

I also reported this problem there, but didn't get a reply at all.

> However if i disable the usb 2.0
> driver (i.e. not loading the ehci driver) which my external
> storage is connected to, then everything works fine - albeit
> it much more slowly. Appears to be a timing issue on some
> usb <-> ide controller chips since not everyone is seeing this.

Well, I only see this with 2.4.22-pre/rc, so this is definitly not a 
hardware-problem, it runs just fine with 2.4.21 at 9950 kB/s.
And running my backup on USB 1.1 is not an option, way to slow.

-- 
Fridtjof Busse
panic("Lucy in the sky....");
	2.2.16 /usr/src/linux/arch/sparc64/kernel/starfire.c

