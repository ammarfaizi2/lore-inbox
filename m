Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWAaHeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWAaHeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWAaHd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:33:59 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:35208
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030304AbWAaHd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:33:59 -0500
Date: Mon, 30 Jan 2006 23:33:54 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.14.7
Message-ID: <20060131073354.GA25397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.7 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14.6 and 2.6.14.7, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                |    2 -
 arch/i386/kernel/io_apic.c              |    4 +-
 arch/sparc64/kernel/entry.S             |    7 +--
 arch/sparc64/kernel/systbls.S           |    2 -
 net/bridge/netfilter/ebt_ip.c           |    3 +
 net/ipv4/netfilter/ip_nat_helper_pptp.c |   59 +++++++++++++++-----------------
 6 files changed, 37 insertions(+), 40 deletions(-)

Summary of changes from v2.6.14.6 to v2.6.14.7
==============================================

Bart De Schuymer:
      Don't match tcp/udp source/destination port for IP fragments

David S. Miller:
      Fix sys_fstat64() entry in 64-bit syscall table.

Greg Kroah-Hartman:
      Linux 2.6.14.7

Patrick McHardy:
      Fix crash in ip_nat_pptp (CVE-2006-0036)
      Fix another crash in ip_nat_pptp (CVE-2006-0037)

Richard Mortimer:
      Fix ptrace/strace

Shaohua Li:
      setting irq affinity is broken in ia32 with MSI enabled

