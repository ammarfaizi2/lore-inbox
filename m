Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbTGBDau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 23:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbTGBDau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 23:30:50 -0400
Received: from adsl-63-195-249-97.dsl.sndg02.pacbell.net ([63.195.249.97]:28548
	"HELO mhughes.dhs.org") by vger.kernel.org with SMTP
	id S264666AbTGBDat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 23:30:49 -0400
Subject: Advice on hangs in 2.5.73-bk6?
From: Matthew Hughes <mhughes@mhughes.dhs.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 01 Jul 2003 21:16:42 -0700
Message-Id: <1057119402.23657.16.camel@mhughes.dhs.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for any advice on how to handle machine hangs in current
2.5 series kernels.

My impression from the periodicals is that the 2.5 series is to the
point where general beta testing is appropriate. I'm interested in the
performance improvements for multimedia apps, so I've been trying out
the new kernels since around 2.5.67 - while the performance is great, 
each version that I've tried hangs consistently within a day or so. 

The box is a uniprocessor AMD Athlon XP1900+ machine that runs 2.4.20
solidly. The distribution is RH 8.0. Earlier versions had occasional
OOPSes in the logs, though not necessarily related to the hangs (see
http://bugme.osdl.org/show_bug.cgi?id=580 for details). 2.5.73-bk6 still
hangs after 4-36 hours of operation, but there are generally no kernel 
messages within 15 or 20 minutes of the hang, and no OOPS messages. 

The hangs are pretty hard - no reply to pings, Ctrl-Alt-Del does
nothing, Magic Sysrq does nothing (though I don't know the status of
this feature in 2.5). 

I'm looking for any advice on steps to take to debug this issue - I know
the problem description is probably too vague to be useful A pointer to
a web site with debugging steps would be great, or if anyone would like
more info or to outline some steps to take it would be much appreciated.
I'm not a kernel developer, but I am a somewhat experienced embedded 
developer, so I could probably manage to get a serial debugger or
something running if that's the appropriate action at this point.

I'm not a subscriber to lkml, so please CC me on any replies.
							Thanks!
							Matt Hughes
						mhughes@mhughes.dhs.org
