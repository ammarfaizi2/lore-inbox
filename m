Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWAINbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWAINbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWAINbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:31:21 -0500
Received: from main.gmane.org ([80.91.229.2]:57017 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751448AbWAINbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:31:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Salvador Fandino <sfandino@yahoo.com>
Subject: Is Sony violating Linux GPL?
Date: Mon, 09 Jan 2006 14:22:07 +0100
Message-ID: <dpto0m$ck3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 178.red-83-41-73.dynamicip.rima-tde.net
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of months ago I bought a Sony Vaio VGN-TX50B. It comes with an
embedded version of Linux used to run a multimedia player (InterVideo
InstantON) without booting the main OS.

A booklet containing a copy of the GPL and other free licenses was
included on the laptop package. A note on the same booklet pointed to
http://www.sony.net/Products/Linux/Download/search.html as the place
were the GPL'ed software could be downloaded.

My laptop has a couple of ports for SD and a MagicGate memories not
supported by Linux, but that are usable from the multimedia player and
so that have to be supported by the custom kernel included on the
laptop. I downloaded the kernel package available from the Sony website
expecting to found the source code for the drivers there, but after
closer examination, I found it was an unmodified copy of the Linux sources.

Then I started mailing Vaio technical support (support@vaio-link.com),
asking for the drivers source code, and after several mails they just
refused to give me the drivers source code because "These drivers are
directly delivered to us by the manufacturers of the hardware and
modified by us and therefore we are not obliged to supply any source
code for these drivers".

I am not an expert on Linux internals but I doubt a driver for this kind
of device could be developed independently enough of the kernel to not
be considered a derived work, so is Sony violating the Linux license?


lspci -v

0000:06:05.3 Mass storage controller: Texas Instruments PCIxx21
Integrated FlashMedia Controller
        Subsystem: Sony Corporation: Unknown device 81e2
        Flags: bus master, medium devsel, latency 57, IRQ 10
        Memory at b0104000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [44] Power Management version 2


Cheers,

  - Salvador

