Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbTCWF7r>; Sun, 23 Mar 2003 00:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTCWF7r>; Sun, 23 Mar 2003 00:59:47 -0500
Received: from imspcml003.netvigator.com ([218.102.32.60]:36774 "EHLO
	imspcml003.netvigator.com") by vger.kernel.org with ESMTP
	id <S262579AbTCWF7q>; Sun, 23 Mar 2003 00:59:46 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
Date: Sun, 23 Mar 2003 14:01:23 +0800
User-Agent: KMail/1.5
x-os: GNU/Linux 2.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303231401.23502.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Have some trouble with loading modules (see earlier message).  
Tried to compile a driver in.

dmesg:
-------
isapnp: Scanning for PnP cards...
isapnp: Card Plug & Play Ethernet card
isapnp: 1 Plug and Play card detected total
------

- no further references do isapnp in logs

- Same card works (with pnp disabled (jumper) and driver compiled 
as a module) by modprobing it with io=0x300


- Same card works with 2.4.21-pre5 driver as module both with pnp 
and modual probing

	Regards
	Michael
