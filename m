Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267616AbUHPM72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267616AbUHPM72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUHPM71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:59:27 -0400
Received: from qwws.net ([213.133.103.108]:28140 "EHLO qwwsII.qwws.net")
	by vger.kernel.org with ESMTP id S267616AbUHPM7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:59:07 -0400
Date: Mon, 16 Aug 2004 14:59:03 +0200
From: Thomas Winkler <tom@qwws.net>
To: linux-kernel@vger.kernel.org
Subject: ARM: PCI Bridge Problems
Message-ID: <20040816125903.GN10616@qwwsII.qwws.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not subscribed to LKM so please CC me on replies.

I'm currently developing for the ARM IXP425 platform.
With Kernel 2.6.7 I've run into PCI related problems. I have
a custom PCI board (with 2 DSPs on it) that is plugged into the
IXDP425 board. In front of the DSPs there is sitting a bridge
chip (TI2050). Unfortunately there is something wrong with
handling the bridge in Kernel 2.6 on ARM. The content of /proc/pci
looks like this:

http://www.wnk.at/tmp/ixp425/proc_pci.txt

This shows the 425 processor sitting behind the bridge which is just
plain wrong.

When using Kernel 2.4.24-uc0 on the very same board the 425 is 
sitting on bus0 as it should.
There is something more I've observed: When pluging in multiple
pci boards with bridges on them the 425 shows up behind every (!)
bridge.

If there is anybody out there who can help me getting this problem
solved I'd really be thankful!

Thanks,
-- 
Tom Winkler

