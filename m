Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276503AbRJCQld>; Wed, 3 Oct 2001 12:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276516AbRJCQlW>; Wed, 3 Oct 2001 12:41:22 -0400
Received: from webcon.net ([216.187.106.140]:9149 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S276503AbRJCQlO>;
	Wed, 3 Oct 2001 12:41:14 -0400
Date: Wed, 3 Oct 2001 12:41:38 -0400 (EDT)
From: Ian Morgan <imorgan@webcon.net>
To: linux-kernel@vger.kernel.org
cc: tech@webcon.net
Subject: ksoftirqd goes bezerk (100% CPU usage)
Message-ID: <Pine.LNX.4.40.0110031218540.9183-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just experienced a very strange new behaviour in 2.4.10:

An SMP box (Dual Celeron 400MHz on a BP6, .5 GB RAM) had both ksoftirqd_CPU0
and ksoftirqd_CPU1 chewing on 100% of the CPU. Everything else on the system
seemed to be working OK other than going really slow because of the load.

I have no idea when this started ('cept sometime within about 12 hours
before noticing it), and there's nothing in the logs to indicate something
going wrong. Any idea what might have caused that? Any way to recover other
than a reboot? Is this even a known problem? I can't find any reports of
people having similar problems.

[Not on list, please CC reply to imorgan at webcon dot net]

Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------

