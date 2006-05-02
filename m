Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWEBWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWEBWaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEBWaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:30:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21445 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965023AbWEBWaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:30:04 -0400
Date: Tue, 2 May 2006 15:28:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.13
Message-ID: <20060502222827.GA29287@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.13
kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.12 and 2.6.16.13, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                     |    2 +-
 net/ipv4/netfilter/ip_conntrack_proto_sctp.c |   11 +++++++----
 net/netfilter/nf_conntrack_proto_sctp.c      |   11 +++++++----
 3 files changed, 15 insertions(+), 9 deletions(-)

Summary of changes from v2.6.16.12 to v2.6.16.13
================================================

Greg Kroah-Hartman:
      Linux 2.6.16.13

Patrick McHardy:
      NETFILTER: SCTP conntrack: fix infinite loop (CVE-2006-1527)

