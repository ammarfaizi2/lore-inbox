Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135494AbRDWSYV>; Mon, 23 Apr 2001 14:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135497AbRDWSYL>; Mon, 23 Apr 2001 14:24:11 -0400
Received: from venus.Sun.COM ([192.9.25.5]:16578 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S135494AbRDWSYA>;
	Mon, 23 Apr 2001 14:24:00 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <32812371f1.371f132812@mysun.com>
Date: Mon, 23 Apr 2001 20:15:26 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: i810_audio broken?
X-Accept-Language: en
Content-Type: multipart/mixed; boundary="--540eaa83eb9773d"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----540eaa83eb9773d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

God afternoon!

The i810 audio driver is broken on my Fujitsu Lifebook
S-4546. All output is just noise. Here is a snip's from
the kernel log.

Intel 810 + AC97 Audio, version 0.02, 19:41:16 Apr 23 2001
PCI: Found IRQ 9 for device 00:00.1
PCI: The same IRQ used for device 00:00.2
PCI: The same IRQ used for device 00:13.1
PCI: Setting latency timer of device 00:00.1 to 64
i810: Intel 440MX found at IO 0x1cc0 and 0x1000, IRQ 9
ac97_codec: AC97 Audio codec, id: 0x594d:0x4800 (Unknown)
i810_audio: only 48Khz playback available

And the lspci:
[root@whyami src]# lspci -vv -s 00:00.1
00:00.1 Multimedia audio controller: Intel Corporation 82440MX AC'97
Audio Controller
	Subsystem: Citicorp TTI: Unknown device 10d0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1cc0 [size=64]



----540eaa83eb9773d
Content-Type: text/x-vcard; name="pworach.vcf"; charset=us-ascii
Content-Disposition: attachment; filename="pworach.vcf
Content-Description: Card for <pworach@mysun.com>
Content-Transfer-Encoding: 7bit

begin:vcard
n:Worach;Pawel
fn:Pawel Worach
version:2.1
email;internet:pawel.worach@mysun.com
end:vcard

----540eaa83eb9773d--

