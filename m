Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291631AbSBAJUu>; Fri, 1 Feb 2002 04:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBAJSh>; Fri, 1 Feb 2002 04:18:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:51922 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291628AbSBAJSR>;
	Fri, 1 Feb 2002 04:18:17 -0500
Date: Fri, 1 Feb 2002 10:16:44 +0100 (CET)
From: Felix Triebel <ernte23@gmx.de>
To: linux-isdn@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: ISDN security ???
Message-ID: <Pine.LNX.4.42.0202011012590.804-100000@mob.wid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when compiling the kernel 2.4.18-pre7, I get the following messages:

md5sum: MD5 check failed for 'isac.c'
md5sum: MD5 check failed for 'isdnl1.c'
md5sum: MD5 check failed for 'isdnl2.c'
md5sum: MD5 check failed for 'isdnl3.c'
md5sum: MD5 check failed for 'tei.c'
md5sum: MD5 check failed for 'callc.c'
md5sum: MD5 check failed for 'cert.c'
md5sum: MD5 check failed for 'l3dss1.c'
md5sum: MD5 check failed for 'l3_1tr6.c'
md5sum: MD5 check failed for 'elsa.c'
md5sum: MD5 check failed for 'diva.c'
md5sum: MD5 check failed for 'sedlbauer.c'
md5sum: MD5 check failed for 'hfc_pci.c'
md5sum: can't open hfc_pci.
cert.c: In function `certification_check':
cert.c:50: warning: control reaches end of non-void function
In file included from /usr/src/linux/include/net/checksum.h:33,
                 from /usr/src/linux/include/net/tcp.h:30,
                                  from slhc.c:75:


What does this mean? Is the ISDN driver corrupt?
Everything works as usual, but this messages make me worry about security!
Is this a known problem? Could someone explain it to me?

kernel messages when loading the modules:

ISDN subsystem Rev: 1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/none/1.1.4.1 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 1.1.4.1
HiSax: Layer2 Revision 1.1.4.1
HiSax: TeiMgr Revision 1.1.4.1
HiSax: Layer3 Revision 1.1.4.1
HiSax: LinkLayer Revision 1.1.4.1
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: AVM PCI driver Rev. 1.1.4.1
PCI: Found IRQ 15 for device 00:0a.0
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:15 base:0xA000
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 15 count 0
AVM Fritz PnP/PCI: IRQ 15 count 5
HiSax: DSS1 Rev. 1.1.4.1
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
isdn: Verbose-Level is 0
HiSax: debugging flags card 1 set to 4
ippp, open, slot: 0, minor: 0, state: 0000
ippp_ccp: allocated reset data structure cef8b800



Thanks,
Felix


ps. please CC me, I'm not subscribed to this list.

