Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278589AbRJ1RX1>; Sun, 28 Oct 2001 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278590AbRJ1RXR>; Sun, 28 Oct 2001 12:23:17 -0500
Received: from ibis.worldnet.net ([195.3.3.14]:35858 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S278589AbRJ1RXM>;
	Sun, 28 Oct 2001 12:23:12 -0500
Message-ID: <3BDC3F24.4D66FA0A@worldnet.fr>
Date: Sun, 28 Oct 2001 18:23:48 +0100
From: Laurent Deniel <deniel@worldnet.fr>
Organization: Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ethernet NIC dual homing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Does someone know if there is some work in the area of NIC dual homing ?
By NIC dual homing, I mean two network devices (e.g. Ethernet) that are
connected to the same IP subnet but only one is active (at IP level) at a 
time. When a faulty condition is detected (e.g. link down or lack of I/O),
the kernel switches to the second NIC. Such a similar feature exists in
Tru64 UNIX (NetRAIN), HP-UX (APA) and Solaris (Sun Cluster pnmd).
What is the best way to handle that in Linux ? I thought about an IP virtual
device that could be mapped on two eternet NIC and some ioctl to switch from
one NIC to another or a generic virtual ethernet driver that could handle two
real ethernet drivers ?

Laurent

PS: please CC to me since I do not read lkml at a regular basis. TIA.
