Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUE2Xtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUE2Xtg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUE2Xtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 19:49:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261234AbUE2Xtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 19:49:32 -0400
Date: Sat, 29 May 2004 19:49:26 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: VIA Velocity Gigabit Driver: update
Message-ID: <20040529234926.GA15549@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted an updated via-velocity driver to 
	ftp://people.redhat.com/alan/Kernel

The new tar ball contains the following changes

	-	Fix two 64bit problems
	-	Fix various formatting and other related cleanup
		things 
	-	Fix crash on down
	-	Switch ethtool to new ethool ops (fixes ethtool crash)
	-	Add power management back
	-	Fix multiple power management bugs in the via driver
		(errors copied from and still present in many existing drivers
		 including 3c59x)
	-	Remove unneeded chain of velocity_info structs
	-	Clean up transmit packet length logic
	-	Added module_license tag note to the header file
	-	Renamed header file to match c file

The driver still lacks copybreak and scatter gather optimisations. I've
tagged a few possible improvements with "FIXME" in the comments if anyone
is interested.

Alan
--
  "... and for $64000 question, could you get yourself vaguely familiar with
		the notion of on-topic posting?"
				-- Al Viro
