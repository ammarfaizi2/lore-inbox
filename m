Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVC2J4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVC2J4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVC2J4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:56:16 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:50584 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262263AbVC2J4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:56:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Tue, 29 Mar 2005 11:56:18 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503291156.19112.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI battery
driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the battery monitor that
I use (the kpowersave applet from SUSE 9.2) is no longer able to report the
battery status (ie how much % it is loaded).  It can only check if the AC power
is connected (if it is connected, kpowersave behaves as though there was
no battery in the box, and if it is not connected, kpowersave always shows
that the battery is 1% loaded).

Also, there are big latencies on loading and accessing the battery module, but
the module loads successfully and there's nothing suspicious in dmesg.

Please let me know if you need any additional information.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
