Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTJJOZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTJJOZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:25:40 -0400
Received: from WARSL402PIP8.highway.telekom.at ([195.3.96.97]:40513 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id S261735AbTJJOZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:25:38 -0400
From: Gregor Burger <gregor.burger@aon.at>
To: linux-kernel@vger.kernel.org
Subject: nforce2 unknown memory device
Date: Fri, 10 Oct 2003 16:25:57 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310101625.57372.gregor.burger@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

linux is not able to detect all the memory installed on my mainboard.
my kernel is 2.4.22 but i tried 2.4.23pre2, 2.6.0-test3-6[mm3].
i tried with 4gb and without. 

lspci schows:
00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller 
(rev a1)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio 
Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)

i tried to switch the memory sticks but nothing. when i install 1024 MB 
ram linux detects 1008; with 512 i get 502.

the xserver can't init agp with the error xf86_ENOMEM; but i think this
is a couse of the missing memory that is not detected.

is that a problem of my hardware (defect) or are the nforce2 chipsets
not yet fully supported?

thanks for your help.

Gregor Burger



