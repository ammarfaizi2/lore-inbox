Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWGXRiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWGXRiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGXRiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:38:11 -0400
Received: from mail.silverbirchstudios.com ([207.176.159.130]:39647 "EHLO mail")
	by vger.kernel.org with ESMTP id S932231AbWGXRiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:38:10 -0400
Date: Mon, 24 Jul 2006 13:38:29 -0400
From: Todd Showalter <tshowalter@silverbirchstudios.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with sky2 driver.
Message-ID: <20060724133829.49bf7979@akemi>
Organization: Silverbirch Studios
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I've been having trouble with the sky2 driver.  It appears to work
most of the time, but it will quite often wedge during transfers.  The
2.6.17.* kernels actually seem worse than 2.6.16.19, but none of them
work perfectly.

    What typically happens is that after working perfectly for a while,
existing net connections hang, and subsequent net connections don't
seem to start at all.  firefox gets stuck with a bunch of half-loaded
pages, for instance, and I've watched an scp of a large file to a
colleague's machine stall and remain stalled.

    Once the machine is behaving this way, a reboot is the only way I
have found of recovering it.

    We have two identical machines here that are both behaving this
way, so I'm assuming it's not a hardware problem per se.  The machines
are Intel Pentium D 940 (3GHz) processors.  They have ASUS P5LD2
motherboards, with builtin Marvell PCIe 88E8053 gigabit ethernet
controllers.

    I'm not running any binary modules; it's an untainted kernel.  I'm
running a Gentoo system, but I'm using the vanilla-sources kernel (ie:
a pure kernel.org release, not the Gentoo-specific patched version).

    What can I do to help solve this?

						Todd.

--
  Todd Showalter,
  Silverbirch Studios.

    
