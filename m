Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131889AbQLNKrz>; Thu, 14 Dec 2000 05:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132025AbQLNKrf>; Thu, 14 Dec 2000 05:47:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13584 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132426AbQLNKrZ>; Thu, 14 Dec 2000 05:47:25 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Thu, 14 Dec 2000 10:18:49 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), shirsch@adelphia.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <200012140457.eBE4vNs43248@aslan.scsiguy.com> from "Justin T. Gibbs" at Dec 13, 2000 09:57:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146VTQ-00045T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BSD has curproc, but that is considerably less likely to be
> used in "inoccent code" than "current".  I mean, "current what?".
> It could be anything, current privledges, current process, current
> thread, the current time...

I see and I assume calling a random collection of data

	u.something

in BSD was even more logical  8)

current is a completely rational name. The problem with current on some of
our ports right now is that its a #define. That is a trap for the unwary and
one day wants fixing.

curproc would be incorrect for linux since its the current task, and a task and
unix process are not the same thing

Alan





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
