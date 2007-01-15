Return-Path: <linux-kernel-owner+w=401wt.eu-S1750978AbXAOR3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXAOR3M (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbXAOR3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:29:12 -0500
Received: from mx.sileman.pl ([217.173.160.41]:59551 "EHLO mx.sileman.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbXAOR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:29:12 -0500
X-Greylist: delayed 2036 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 12:29:11 EST
From: "ris" <ris@elsat.net.pl>
To: linux-kernel@vger.kernel.org
Subject: High CPU usage with sata_nv
Date: Mon, 15 Jan 2007 18:54:50 +0200
Message-Id: <20070115165432.M87238@elsat.net.pl>
In-Reply-To: <20070115164541.M22367@elsat.net.pl>
References: <20070115164541.M22367@elsat.net.pl>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 217.173.173.29 (ris)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
X-SILEMAN-MailScanner-Information: Please contact the ISP for more information
X-SILEMAN-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SILEMAN-MCPCheck: MCP-Clean, MCP-Checker (score=-4.9, required 1,
	BAYES_00 -4.90)
X-SILEMAN-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9,
	required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have motherboard with nforce 590 SLI (MCP55) chipset.
On other systems all its ok.

But i tried a lot o kernels, configurations and always get cpu at 100% when
copying files.
I use SATA II samsung hard drive.

There is my lspci

00:0c.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1) (prog-if 8a [Master
 SecP PriP])
        Subsystem: Unknown device f043:8223
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at f400 [size=16]
        Capabilities: [44] Power Management version 2

00:0d.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2) (prog-i
f 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8223
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 23
        I/O ports at 09f0 [size=8]
        I/O ports at 0bf0 [size=4]
        I/O ports at 0970 [size=8]
        I/O ports at 0b70 [size=4]
        I/O ports at e000 [size=16]
        Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping

00:0d.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2) (prog-i
f 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8223
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
        I/O ports at 09e0 [size=8]
        I/O ports at 0be0 [size=4]
        I/O ports at 0960 [size=8]
        I/O ports at 0b60 [size=4]
        I/O ports at cc00 [size=16]
        Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping

00:0d.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2) (prog-i
f 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 8223
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
        I/O ports at c800 [size=8]
        I/O ports at c400 [size=4]
        I/O ports at c000 [size=8]
        I/O ports at bc00 [size=4]
        I/O ports at b800 [size=16]
        Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping
------- End of Forwarded Message -------



