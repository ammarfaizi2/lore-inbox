Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUDSPho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbUDSPho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:37:44 -0400
Received: from node249-201.sim.db.erau.edu ([155.31.249.201]:27776 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263713AbUDSPhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:37:41 -0400
Subject: How to make Linux route multicast traffic bi-directionly between
	multible subnets
From: John Pesce <pescej@sprl.db.erau.edu>
Reply-To: pescej@sprl.db.erau.edu
To: linux-kernel@vger.kernel.org
Cc: pescej@sprl.db.erau.edu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082389059.1982.15.camel@inferno>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Apr 2004 11:37:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel 2.4.20-8.

I have a Linux box multi-homed on three subnets using three NICs in
order to route TCP and UDP traffic between them.

I would like to also like route specific multicast group traffic between
them. I've read the multicast-howto and crawled the popular search
engines but I can not find any documentation to do it.
I have three NICs on subnets A,B and C.
Any multicast traffic arriving from any one of them needs to be
forwarded to the other two so the clients can received it.

The only thing I have been able to do is set a default multicast route
to subnet A. This forwards traffic incoming from B and C to A, but what
about the other ways?

Some pages refer to something called mrouted but it is all dated like
1996. Did multicast routing die off into the realm of hardware routers
??

I see on bootup a kernel message about 0.96 PIM-SM. Can I somehow use
that?

Please help.

I'm not on the mailing list so please CC me personally.

Thank you,
John
