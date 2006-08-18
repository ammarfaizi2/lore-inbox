Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbWHRQjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWHRQjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWHRQjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:39:37 -0400
Received: from ns1.suse.de ([195.135.220.2]:65228 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030485AbWHRQjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:39:36 -0400
Date: Fri, 18 Aug 2006 09:38:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.9
Message-ID: <20060818163831.GA16920@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.9 kernel.

It contains one security fix that everyone running Linux on PPC970
systems with untrusted users should apply.

I'll also be replying to this message with a copy of the patch between
2.6.17.8 and 2.6.17.9, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                               |    2 +-
 arch/powerpc/kernel/cpu_setup_power4.S |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

Summary of changes from v2.6.17.8 to v2.6.17.9
==============================================

Greg Kroah-Hartman:
      Linux 2.6.17.9

Olof Johansson:
      powerpc: Clear HID0 attention enable on PPC970 at boot time (CVE-2006-4093)

