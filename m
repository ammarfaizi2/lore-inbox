Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUHDUDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUHDUDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUHDUDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:03:51 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:53959 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S267377AbUHDUDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:03:47 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 3c59x very slow with 2.6.X
Date: Wed, 4 Aug 2004 22:03:41 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408042203.42367.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

somehow the network speed is reduced to 14MBit with 2.6.X on my system, with 
2.4.X it has full 100MBit.
As all our systems boot diskless this is really annoying and I will reboot 
2.4.27 soon.

euklid:~# nttcp -T hamilton2
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    4.73    4.60     14.2004     14.5911    2048    433.36     445.3
1  8388608    4.73    0.03     14.1984   2236.9621    6145   1300.12  204833.3


from dmesg:

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb800. Vers LK1.1.19


euklid:~# mii-tool 
eth0: 100 Mbit, full duplex, link ok


Any ideas whats going on?



Please tell me if you need further information.

Cheers,
	Bernd


PS: Happens with 2.6.7 and 2.6.8-rc2-mm2

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
