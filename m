Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVAUXQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVAUXQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAUXQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:16:45 -0500
Received: from pop-a065b10.pas.sa.earthlink.net ([207.217.121.170]:1761 "EHLO
	pop-a065b10.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262572AbVAUXDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:03:43 -0500
From: John Mock <kd6pag@qsl.net>
To: David Woodhouse <dwmw2@infradead.org>, greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage]
Message-Id: <E1Cs7o8-00032u-00@penngrove.fdns.net>
Date: Fri, 21 Jan 2005 15:03:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We always used to byte-swap just a few fields in the descriptor, to
> optimise access to those. We never bothered to put them back when we
> passed them up to userspace via usbdevfs -- we gave a structure which
> was mostly LE but had precisely four fields byteswapped to host-endian.

> The upstream version of usbutils doesn't expect this -- it expects the
> descriptor to be entirely little-endian, as it's received from the
> device. John's version of usbutils (which distro, is that, btw?)
> evidently has a hack to work around it.

I'm running Debian 'Sarge' and there are currently no bug reports for
either 'usbutils' or 'libusb'.

I would support doing things consistently, especially if the relevant 
utility(s) can readily determine whether byte-swapping is necessary or 
not.
				   -- JM

P.S. Other readers:  Hey, what about the SCSI oops???
-------------------------------------------------------------------------------
-- System Information:
Debian Release: 3.1
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: powerpc (ppc)
Kernel: Linux 2.6.10
Locale: LANG=C, LC_CTYPE=C (charmap=ANSI_X3.4-1968)

Versions of packages usbutils depends on:
ii  libc6                       2.3.2.ds1-20 GNU C Library: Shared libraries an
ii  libusb-0.1-4                1:0.1.8-17   Userspace USB programming library

-- no debconf information
===============================================================================
