Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbTCGOZ6>; Fri, 7 Mar 2003 09:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTCGOZ5>; Fri, 7 Mar 2003 09:25:57 -0500
Received: from [203.200.144.45] ([203.200.144.45]:59150 "EHLO
	mx-out-01.nestec.net") by vger.kernel.org with ESMTP
	id <S261597AbTCGOZ4>; Fri, 7 Mar 2003 09:25:56 -0500
Organization: NeST-India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A5153AB5@pdc2.nestec.net>
From: SANTHOSH K <santhoshk@nestec.net>
To: "'rmk@arm.linux.org.uk'" <rmk@arm.linux.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: cardbus driver
Date: Fri, 7 Mar 2003 19:47:53 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a board with cardbus support. And a WLAN card driver with pci
support. So i could not use this WLAN card in this board. So I need to
support Cardbus in the wlan driver.

-----Original Message-----
From: Russell King [mailto:rmk@arm.linux.org.uk]
Sent: Friday, March 07, 2003 8:01 PM
To: SANTHOSH K
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: cardbus driver


On Fri, Mar 07, 2003 at 07:08:29PM +0530, SANTHOSH K wrote:
> What change need to be done to give support for a pccard driver to a
cardbus
> driver?

Electrically, they're different interfaces.  If the controller hardware
you're using doesn't support cardbus cards, no amount of software will
make them work.

Could you give some details about the hardware and the driver?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM
Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
