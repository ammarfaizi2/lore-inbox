Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSGAUS1>; Mon, 1 Jul 2002 16:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSGAUS0>; Mon, 1 Jul 2002 16:18:26 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:6091 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316446AbSGAUSZ>; Mon, 1 Jul 2002 16:18:25 -0400
Date: Mon, 1 Jul 2002 22:20:26 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: [2.5.24] RTL8139: ioctl(SIOCGIFHWADDR): No such device
Message-ID: <20020701202026.GA896@neon.hh59.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Environment: Kernel 2.5.24, SuSE Linux 7.2, Intel Chipset 440FX

NIC: RTL1839 connected to ADSL Modem

When trying to connect to ADSL, I get the following error msgs (I guess the
"ioctl(SIOCGIFHWADDR): No such device" is the important part):

pppd[823]: pppd 2.4.1 started by root, uid 0
pppd[823]: Using interface ppp0
pppd[823]: Connect: ppp0 <--> /dev/pts/0
pppoe[824]: ioctl(SIOCGIFHWADDR): No such device
pppd[823]: Modem hangup
pppd[823]: Connection terminated.
pppd[823]: Exit.


Have not tried 2.5.23 but 2.5.22 works fine. Since there have been changes to 
the 8139too driver I guess thats it. Unfortunately I do not know where to fix
this.

Regards,
Axel
