Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289733AbSAWIXc>; Wed, 23 Jan 2002 03:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289732AbSAWIXU>; Wed, 23 Jan 2002 03:23:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289730AbSAWIXI>; Wed, 23 Jan 2002 03:23:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: kernel.org: setting the record straight
Date: 23 Jan 2002 00:23:02 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2lrt6$d96$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has come to my attention there are some unfounded rumours about the
kernel.org outage from this past weekend, and I wanted to set the
record straight:

In particular, the outage was *not* caused by any kind of failure in
the new Compaq server hardware.  It worries me a bit that this
particular rumour was circulating, since it reflects badly on a donor
who has just provided us with a very nice machine.

The approximate history of the failure is as such:

Back in December, we were already planning to replace the old server
hardware after repeated problems, probably age-related.  We were
originally planning to put the new server in production after the
holidays, however, when the old server really started to flake out on
us we decided to push it in service early.

ISC was very accomodating and arranged for us to put it in service on
short notice, despite several logistics problem.  One of those
problems was the lack of a configured port for the management card in
the new server.  As a result, it did not get wired up at that time.

This past Friday morning, the kernel on the server apparently stopped
servicing user-space processes; the details aren't known, other than
the fact that pings and TCP SYNs received replies, but we couldn't get
any actual data across.  Futhermore, on and off there was as much as
95% packet loss in pings, although the machine didn't stop responding
to pings until it was power cycled on Sunday.

Due to a miscommunication between myself and the staff at ISC we
weren't able to get the machine power cycled until Sunday (it did not
return from the power cycle) and the management port connected until
Monday.  Once the management port got connected, it was a 5-minute job
to bring the machine back to life.

Finally, I would like to thank the many people and organizations who
have offered to host another kernel.org server in one way or another.
I'm going to be evaluating our options, with the goal of getting at
least one additional server if at all possible.  If so, my preference
will definitely be to try to obtain identical hardware with the one we
currently have.

	  -=hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
