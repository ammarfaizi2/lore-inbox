Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTGNSme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTGNSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:42:34 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:40899 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S270707AbTGNSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:41:39 -0400
Subject: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
	installed)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058196612.3353.2.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-2) 
Date: 14 Jul 2003 14:56:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I now get past the initialization of the 3c920.  However, now it
hangs (sak enabled, sak doesn't work... completely dead) when eth0 tries
to come up.  I have IPv6 enabled (the router does 6to4, this isn't the
router), I don't believe I have any firewall stuff on this box, it does
dhcp for IPv4 address and ntp time.

There was an oops earlier in the boot process.  It seems the sound card
(irq 3) did an irq and the kernel wasn't ready to accept so it barfed. 
There may have been more to it than that, I will check later today.  I
have to get back to my studies for now.

Trever
--
"My spelling is Wobbly. It's good spelling but it Wobbles, and the
letters get in the wrong places." -- A. A. Milne (1882-1958)

