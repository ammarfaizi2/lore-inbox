Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTHLPm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTHLPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:42:25 -0400
Received: from cpmail5.sol.no1.asap-asp.net ([195.225.3.232]:16552 "HELO
	cpmail5.sol.no1.asap-asp.net") by vger.kernel.org with SMTP
	id S270461AbTHLPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:42:04 -0400
Date: Tue, 12 Aug 2003 18:42:01 +0300
Message-ID: <3F28427C0000944B@webmail-fi2.sol.no1.asap-asp.net>
In-Reply-To: <20030812091056.GA13487@atrey.karlin.mff.cuni.cz>
From: zipa24@suomi24.fi
Subject: RE: Hangup on nforce2 UDMA
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heip!

>I have nforce2 motherboard Soltek SL75FRN2-L with MCP southbridge. Using
>2.4.21 with AMD 74xx driver for IDE. If I leave the UDMA5 (UATA-100)
>setting BIOS leaves on the IDE disk I can hangup the machine almost
>deterministically with
>
>cat /dev/hda > /dev/null 

I have nForce2 motherboard ASUS A7N8X Deluxe, and I have a similar problem.


>When UDMA is disabled in BIOS, I get lower performance of 17MB/s instead
>of 40MB/s. I have also tried IGNORE word93 Validation BITS and AMD Viper
>ATA-66 Override and none helped.

I could 'fix' the problem by doing "hdparm -qd1qk1qX67 /dev/hd[ab]" in initrc
which reduced the theoretical speed 'only' to 44.4MB/s.


>Cl<

// /

_____________________________________________________________
Kuukausimaksuton nettiyhteys: http://www.suomi24.fi/liittyma/
Yli 12000 logoa ja soittoääntä: http://sms.suomi24.fi/


