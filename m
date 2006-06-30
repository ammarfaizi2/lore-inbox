Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWF3Vuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWF3Vuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWF3Vuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:50:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33702 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750890AbWF3Vuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:50:44 -0400
Date: Fri, 30 Jun 2006 14:47:15 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: stable@kernel.org, torvalds@osdl.org
Subject: Linux 2.6.16.23
Message-ID: <20060630214715.GA12143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.23 kernel.
Another SCTP remote crash fix, CVE-2006-2934, and a revert of a Kconfig
change that should have have gone into the 2.6.16-stable tree.

I'll also be replying to this message with a copy of the patch between
2.6.16.22 and 2.6.16.23, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                     |    2 +-
 drivers/parport/Kconfig                      |    2 +-
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |    2 +-
 net/netfilter/nf_conntrack_proto_sctp.c      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Summary of changes from v2.6.16.22 to v2.6.16.23
================================================

Chris Wright:
      revert PARPORT_SERIAL should depend on SERIAL_8250_PCI patch

Greg Kroah-Hartman:
      Linux 2.6.16.23

Patrick McHardy:
      NETFILTER: SCTP conntrack: fix crash triggered by packet without chunks [CVE-2006-2934]
