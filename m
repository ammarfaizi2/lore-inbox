Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbTHTJup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 05:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTHTJuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 05:50:44 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49303 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261822AbTHTJuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 05:50:44 -0400
Subject: [Fwd: RE: [2.4 PATCH] bugfix: ARP respond on all devices]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061373020.32594.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Aug 2003 10:50:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I can't believe that you're advocating networking code where:
> 
> 1) It's not predictable - the route of a packet depends on the ARP reply
> generated due to a previous packet.

I'm not. Apply your brain a little. Being able to do lookups via two paths
in parallel is just fine since you can tie the packet path to a specific 
lookup, and in the case of multipathing to the same target it does the right
thing too.


