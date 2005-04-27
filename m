Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVD0LNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVD0LNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVD0LNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:13:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:49588 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261426AbVD0LN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:13:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Date: Wed, 27 Apr 2005 13:13:31 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <E1DQkId-0007AA-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1DQkId-0007AA-00@calista.eckenfels.6bone.ka-ip.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271313.31865.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 of April 2005 13:01, Bernd Eckenfels wrote:
> In article <200504271152.15423.rjw@sisk.pl> you wrote:
> > I'm having a problem with 2.6.12-rc3 and the Java VM (from SuSE 9.2)
> > on AMD64.
> 
> Java  sux sometimes pretty much. Why it cannot be killed? is the system too
> slow for X to responde, or have you been able to use kill -9? Maybe it
> spawns threads too fast, try to "killall -9 java".

No.  It is exactly _one_ Java process that _does_ _not_ _react_ to kill -9.  Apart
from this, the system is responsive and the other processes get their CPU
share as usual (eg if I run another process that normally would get ~100%
of the CPU, now it gets 50% of it and the rest is "used" for the Java).

It looks like a kernel bug to me this time.

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
