Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSL1XFe>; Sat, 28 Dec 2002 18:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbSL1XFe>; Sat, 28 Dec 2002 18:05:34 -0500
Received: from nsinat.nsinoc.com ([208.34.42.193]:49070 "EHLO
	exch-tmp.NetStandard.inc") by vger.kernel.org with ESMTP
	id <S266384AbSL1XFW> convert rfc822-to-8bit; Sat, 28 Dec 2002 18:05:22 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: natsemi.c - Problems/Questions
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Sat, 28 Dec 2002 17:12:19 -0600
Message-ID: <F2FB3991BE3CDF4DA44A432802BE339403AB87@exch-tmp.netstandard.inc>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: natsemi.c - Problems/Questions
Thread-Index: AcKuxpHT/MbLXHdERm6pKlSuWFtgkQ==
From: "Andrew Brink" <abrink@netstandard.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Christian North" <cnorth@netstandard.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a laptop here that has an onboard National Semiconductor
DP8381[56] Ethernet Controller that I've been trying to get to work for
several days now, I must now ask for outside help as this might be a bug
in the driver, I'm not too sure.

I'm using kernel 2.4.20 with the default natsemi dp8381x driver, version
1.07+LK1.0.17

On boot it seems to recognize the interface:
PCI: Found IRQ 5 for device 00:12.0
eth0: NatSemi DP8381[56] at 0xe08000000, 00:c0:9f:15:0f:c1, IRQ 5.

However, when I try to do 'ifconfig eth0 192.168.1.5' I get: "eth0: link
up."
That's when things go astray, for the link is not actually up, the link
light on the up does not light up, and eth0 does nothing.

I'm looking for suggestions on why this is, I can boot the laptop to XP
Pro and the card works there.

Additional Info From /proc/ioports:
1c00-1cff : National Semiconductor Corporation DP83815 (MacPhyter)
Ethernet Controller
	1c00-1cff : eth0

Any suggestions would be great, TIA.

Andrew Brink, CCNA, WCSP 
NetStandard, Inc. 
913-262-3888 
