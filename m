Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWGQOML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWGQOML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWGQOLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:11:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:27108 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750784AbWGQOLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:11:45 -0400
Date: Mon, 17 Jul 2006 07:08:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.16.26
Message-ID: <20060717140852.GA11675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.27 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.16.26 and 2.6.16.27, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                      |    2 -
 drivers/usb/serial/ftdi_sio.c |   84 +++++++++++++++++++++++++++++++++++-------
 net/ipv6/addrconf.c           |    9 ++++
 3 files changed, 81 insertions(+), 14 deletions(-)

Summary of changes from v2.6.16.26 to v2.6.16.27
================================================

$,1 aukasz Stelmach:
      IPV6: Fix source address selection.

Greg Kroah-Hartman:
      Linux 2.6.16.27

Ian Abbott:
      USB serial ftdi_sio: Prevent userspace DoS (CVE-2006-2936)

YOSHIFUJI Hideaki:
      IPV6 ADDRCONF: Fix default source address selection without CONFIG_IPV6_PRIVACY

