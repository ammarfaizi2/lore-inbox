Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHWVib>; Fri, 23 Aug 2002 17:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHWVib>; Fri, 23 Aug 2002 17:38:31 -0400
Received: from imo-d10.mx.aol.com ([205.188.157.42]:62459 "EHLO
	imo-d10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S312558AbSHWVia>; Fri, 23 Aug 2002 17:38:30 -0400
Message-ID: <3D6674BA.7040201@netscape.net>
Date: Fri, 23 Aug 2002 17:45:30 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com, Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.31 port PnP BIOS to the driver model
References: <3D5D7E50.4030307@netscape.net>	<20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net>	<20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060702050009000909080109"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------060702050009000909080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch ports the PnP BIOS driver to the driver model as well 
as other improvements in driver and device management.  It has been tested.

Thanks,
-Adam

The following are potential changes for future pnpbios patches listed in 
order of priority.  Let me know if you support them.

1.) Add pnpbios specific interfaces to the driver model, this includes 
resource management and escd.
2.) add pnpbios dev id list support, similiar to the devlist found in pci
3.) remove dependancy on struct pci_dev and create a pnpbios specific 
dev structure
4.) split the pnpbios files into smaller more manageable files as well 
as other cleanups
5.) port some drivers to use the pnpbios driver if available.  Should 
this include the pci driver?

--------------060702050009000909080109
Content-Type: application/octet-stream;
 name="pnpbios1.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pnpbios1.patch.gz"

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
X7197dkzPwh/AA9kuh3jGQAA
--------------060702050009000909080109--
