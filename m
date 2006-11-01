Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752242AbWKASEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbWKASEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbWKASEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:04:51 -0500
Received: from www.nabble.com ([72.21.53.35]:5269 "EHLO talk.nabble.com")
	by vger.kernel.org with ESMTP id S1752242AbWKASEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:04:50 -0500
Message-ID: <7119134.post@talk.nabble.com>
Date: Wed, 1 Nov 2006 10:04:50 -0800 (PST)
From: parshant <parshant05@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PHY driver for linux 2.6.11.12
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: parshant05@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I want to write a phy driver for linux kernel version 2.6.11.12. 
My requirement is phy driver code will not be a part of linux ethernet
driver. I mean all the phy management code go in phy driver and the
data transmit/receive related code go in mac driver.Mac driver will export
me 
mdio-write and mdio-read(phy connected through MII to Mac).IF any body has
ne 
idea about this please help me out.

I also want to know is i need to register phy driver as a seaprate network
driver.
or how any userspace code can coummnicate to my phy driver like ethtool or 
mii-tool.
-- 
View this message in context: http://www.nabble.com/PHY-driver-for-linux-2.6.11.12-tf2554855.html#a7119134
Sent from the linux-kernel mailing list archive at Nabble.com.

