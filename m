Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVHSFRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVHSFRB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 01:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVHSFRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 01:17:01 -0400
Received: from pop.gmx.net ([213.165.64.20]:3221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932404AbVHSFQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 01:16:59 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050819064426.00c59e68@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 19 Aug 2005 07:16:49 +0200
To: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Debugging kernel semaphore contention and priority 
  inversion
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC0830FE03@cof110avexu4.glob
 al.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0532-0, 08/08/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:50 AM 8/18/2005 -0600, Davda, Bhavesh P \(Bhavesh\) wrote:
>
> > Sounds like there must be another player who is RT prio + spinning.
>
>Very good! Yes, I left out that piece of detail in my original posting.
>There is a real low priority (4) SCHED_FIFO (hence still higher than any
>SCHED_OTHER) task spinning.

That's a (fairly) deadly bug.

         -Mike

