Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVATQuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVATQuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVATQqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:46:47 -0500
Received: from pv106075.reshsg.uci.edu ([128.195.106.75]:46284 "EHLO
	alpha.blx4.net") by vger.kernel.org with ESMTP id S262189AbVATQm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:42:27 -0500
Message-ID: <41EFDF7B.40408@blx4.net>
Date: Thu, 20 Jan 2005 08:42:35 -0800
From: Mathias Kretschmer <posting@blx4.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041218
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Asus A7N8X-E ACPI S3 resume hangs with 2.6.10 and 2.6.11-rc1
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020407000706000009070902"
X-Sanitizer: This message has been sanitized!
X-Sanitizer-URL: http://mailtools.anomy.net/
X-Sanitizer-Rev: $Id: Sanitizer.pm,v 1.83 2004/03/23 12:33:48 bre Exp $
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020407000706000009070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I haven't tried any earlier kernel. Problem exists with 2.6.10 and 
2.6.11-rc1.  System seems to suspend ok. When I press the power button 
the fans turn on again, the IDE LED seems to flash a little and then 
stays on permanently. System hangs. Display is still off, so I don't 
know if there are any kernel messages. All I can do is hit the Reset 
button. S1 works fine.

Under WinXP S3 works.

Does anyone see the same problem ?

Mathias



--------------020407000706000009070902
Content-Type: application/DEFANGED-13721; name="lspci_out.DEFANGED-13721"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="lspci_out.DEFANGED-13721"

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:04.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 13)
0000:01:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
0000:01:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
0000:01:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 62)
0000:01:0a.3 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
0000:03:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If [Radeon 9000] (rev 01)

--------------020407000706000009070902
Content-Type: text/sanitizer-log; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="sanitizer.log"

This message has been 'sanitized'.  This means that potentially
dangerous content has been rewritten or removed.  The following
log describes which actions were taken.

Sanitizer (start="1106239356"):
  Part (pos="1132"):
    SanitizeFile (filename="unnamed.txt", mimetype="text/plain"):
      Match (names="unnamed.txt", rule="9"):
        Enforced policy: accept

  Part (pos="1737"):
    SanitizeFile (filename="lspci.out", mimetype="text/plain"):
      Match (rule="default"):
        Enforced policy: defang

      Replaced mime type with: application/DEFANGED-13721
      Replaced file name with: lspci_out.DEFANGED-13721

  Total modifications so far: 1


Anomy 0.0.0 : Sanitizer.pm
$Id: Sanitizer.pm,v 1.83 2004/03/23 12:33:48 bre Exp $

--------------020407000706000009070902--
