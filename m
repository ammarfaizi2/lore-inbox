Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVF1Oqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVF1Oqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVF1Oqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:46:44 -0400
Received: from dsl093-119-032.blt1.dsl.speakeasy.net ([66.93.119.32]:9092 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S261675AbVF1OqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:46:01 -0400
Date: Tue, 28 Jun 2005 10:45:51 -0400 (EDT)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: "Jason R. Martin" <nsxfreddy@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bonding driver issues: slave interface not coming up
In-Reply-To: <c295378405062713485b7e071d@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0506281044200.23329@bushido>
References: <Pine.LNX.4.63.0506271620160.12410@bushido>
 <c295378405062713485b7e071d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (bushido.realityfailure.org [10.0.0.10]); Tue, 28 Jun 2005 10:45:53 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Jason R. Martin wrote:

> What's in /proc/net/bonding/bond0?

before a successful ifdown/ifup bond0:

Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)

Bonding Mode: load balancing (xor)
MII Status: up
MII Polling Interval (ms): 1000
Up Delay (ms): 0
Down Delay (ms): 3000

Slave Interface: eth0
MII Status: down
Link Failure Count: 1
Permanent HW addr: 00:09:3d:11:8d:93

Slave Interface: eth1
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:09:3d:11:8d:94

after a successful ifdown/ifup bond0:
Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)

Bonding Mode: load balancing (xor)
MII Status: up
MII Polling Interval (ms): 1000
Up Delay (ms): 0
Down Delay (ms): 3000

Slave Interface: eth0
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:09:3d:11:8d:93

Slave Interface: eth1
MII Status: up
Link Failure Count: 0
Permanent HW addr: 00:09:3d:11:8d:94

> You'll probably have better luck getting help with this issue on
> netdev@vger.kernel.org and bonding-devel@lists.sourceforge.net.

Thanks. I will email them shortly.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- No one will sorrow for me when I die, because those who would
-- are dead already. -- Lan Mandragoran, The Wheel of Time, New Spring
