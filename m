Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRD3Meu>; Mon, 30 Apr 2001 08:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRD3Mel>; Mon, 30 Apr 2001 08:34:41 -0400
Received: from eastgate.starhub.net.sg ([203.116.1.189]:61709 "EHLO
	eastgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id <S133088AbRD3Meg>; Mon, 30 Apr 2001 08:34:36 -0400
Message-ID: <XFMail.010430205941.hosler@lugs.org.sg>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 30 Apr 2001 20:59:41 +0800 (SGT)
Reply-To: Greg Hosler <hosler@lugs.org.sg>
From: Greg Hosler <hosler@lugs.org.sg>
To: linux-kernel@vger.kernel.org
Subject: Via VT82C686 data sheet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have, or know where I can get a copy of the above ?

The onboard AC97 sound driver (via82cxxx_audio) was rewritten from legacy
(which works both in UP and SMP kernels), to do w/o the legacy support,
and go native. The problem is that the new driver doesn't properly handle
enabling interrupts for the case when the IRQ has been reassigned (by
the I/O APIC, which is typical under SMP). (actually the via82cxxx_audio
has code to try to handle the reassignment of the IRQ, but it doesn't work).

I'm looking to see a copy of the datasheet on the 82C686, to see if I can
debug this further.

thx for any pointers, and rgds,

-Greg

+---------------------------------------------------------------------+
"DOS Computers manufactured by companies such as IBM, Compaq, Tandy, and
millions of others are by far the most popular, with about 70 million
machines in use wordwide. Macintosh fans, on the other hand, may note that
cockroaches are far more numerous than humans, and that numbers alone do
not denote a higher life form."       (New York Times, November 26, 1991)
| Greg Hosler                           i-net:  hosler@lugs.org.sg    |
+---------------------------------------------------------------------+
