Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSLJO66>; Tue, 10 Dec 2002 09:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSLJO66>; Tue, 10 Dec 2002 09:58:58 -0500
Received: from compsci.wm.edu ([128.239.33.10]:52104 "EHLO compsci.wm.edu")
	by vger.kernel.org with ESMTP id <S262190AbSLJO66>;
	Tue, 10 Dec 2002 09:58:58 -0500
Date: Tue, 10 Dec 2002 10:06:42 -0500
From: Mike <mibarnes@tni.net>
To: linux-kernel@vger.kernel.org
Subject: tlb flush timeout on SMP alphas
Message-ID: <20021210100642.A32163@star.compsci.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to figure out if the timeouts I am getting are software or
hardware related.  We've got 2 way alphas with 4 gig of ram and the only
other different hardware in them is a Myrinet card with the GM driver.
And I can frequently (not 100% reliably) get tlb flush timeouts while
the system has a load of around 2 and one of the running processes is
using the mryinet card.

When this message occurs, one of the 2 CPUs is "dead", meaning that any
processes running on it are copletly stalled and the rtc for the "dead"
processor in /proc/interupts does not increase.

An interesting datapoint is that the air conditioner failed one weekend
and some machines died because of the heat and these machines failed
with the same tlb flush timeouts.

Currently we are running 2.4.9 (redhat modified) kernel, and have tried
others up to and including 2.4.18 with the same results.

Any insight would be greatly appreciated.

I am not a subscriber on this list, so CCing me would be greatly
appreciated.

Mike
