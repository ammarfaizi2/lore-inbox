Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135345AbRD3PNg>; Mon, 30 Apr 2001 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRD3PN1>; Mon, 30 Apr 2001 11:13:27 -0400
Received: from eastgate.starhub.net.sg ([203.116.1.189]:23301 "EHLO
	eastgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id <S135345AbRD3PNR>; Mon, 30 Apr 2001 11:13:17 -0400
Message-ID: <XFMail.010430233825.hosler@lugs.org.sg>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 30 Apr 2001 23:38:25 +0800 (SGT)
Reply-To: Greg Hosler <hosler@lugs.org.sg>
From: Greg Hosler <hosler@lugs.org.sg>
To: linux-kernel@vger.kernel.org
Subject: AC'97 (VT82C686A) & IRQ reassignment (I/O APIC)
Cc: jgarzik@mandrakesoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The AC'97 has an IRQ register which allows for IRQ's 1, and 3 thru 14
(page 107 of the VT82C686 datasheet, under section "Offset 3C, Interrupt Line")

The problem I'm seeing is that on a SMB machine, the IRQ's get reassigned by
the I/O APIC code, and my AC'97 gets assigned an IRQ of 18 (which won't fit into
4 bits :(

Is there any way to reassign an IRQ to one that teh AC'97 will be happy with ?

Does any other device already have to do this ?

thx, and rgds,

-Greg

+---------------------------------------------------------------------+
"DOS Computers manufactured by companies such as IBM, Compaq, Tandy, and
millions of others are by far the most popular, with about 70 million
machines in use wordwide. Macintosh fans, on the other hand, may note that
cockroaches are far more numerous than humans, and that numbers alone do
not denote a higher life form."       (New York Times, November 26, 1991)
| Greg Hosler                           i-net:  hosler@lugs.org.sg    |
+---------------------------------------------------------------------+
