Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUG2XJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUG2XJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUG2XIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:08:01 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31148 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267517AbUG2XDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:03:20 -0400
Subject: Re: [patch] IRQ threads
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rlrevell@joe-job.com
Content-Type: text/plain
Organization: 
Message-Id: <1091133199.1232.1384.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Jul 2004 16:33:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell writes:

> As I understand it there will still be a place for the
> current hard-RT Linux solutions, because even if I can
> get five nines latency better than N, this is not good
> enough for hard RT, as you need to be able to mathematically
> demonstrate that you can *never* miss a deadline.

Nah, that's academic theory. There is no such thing
as hard-RT in the real world.

In reality, there's no point in making the software far
more reliable than the hardware, power supply, and so on.
Somebody may pour a can of Mountain Dew into the vent holes.

Your software is OK as long as other causes of failure
are much more likely. One might even say you spent too
much of your budget perfecting the software! In the end it
all comes down to $$$ (or Euros, or Yen...), doesn't it?

People don't mathematically demonstrate anything about
modern systems, at least not while being honest. Modern
systems have cache memory, interrupts. compiled code...
Use an Intel 4004 if you want mathematical proofs, and
even then, remember the can of Mountain Dew. (and bugs!)
Heh, your proof could be buggy. Then what?

Math problem:

The cost of the system is inversly proportional to the
likelyhood of failure. Set the likelyhood of failure
to zero and solve for the cost. :-)

That won't make the customer happy.


