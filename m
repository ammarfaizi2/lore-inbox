Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbUCNNmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 08:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbUCNNmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 08:42:13 -0500
Received: from 5.109.203.213.9lyon1-0-ro-bas-1.9tel.net ([213.203.109.5]:57479
	"EHLO inspiron.netbadri.com") by vger.kernel.org with ESMTP
	id S263362AbUCNNmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 08:42:10 -0500
Message-ID: <1079271708.4054611cbf525@webmail.netbadri.com>
Date: Sun, 14 Mar 2004 14:41:48 +0100
From: Mohamed Badri <mohamed@netbadri.com>
To: linux-kernel@vger.kernel.org
Subject: Wrong device id for pcmcia cards
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with device ids with my linux kernel ( 2.4.23 )
when using pcmcia cards,
for example :

=====================
an ethernet card with rtl8139 chip ( Vendor id : Device id => 10ec:8139 )
output of lspci :
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device
0139 (rev 10)

instead of :
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

=====================
a wireless card with ti acx100 chipset ( Vendor id: Device id => 104c:8400 )

output of lspci :
03:00.0 Network controller: Texas Instruments: Unknown device 0400

instead of:
07:00.0 Network controller: Texas Instruments USR2210 22Mbps Wireless PC Card

Don't know why it doesn't work, My kernel run without pnp.
Can someone explain this strange things ? or have any solution ?

thanks in advance.

---------------------------
http://webmail.netbadri.com
