Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131834AbRCOUZo>; Thu, 15 Mar 2001 15:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131836AbRCOUZe>; Thu, 15 Mar 2001 15:25:34 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:61610 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S131834AbRCOUZ0>; Thu, 15 Mar 2001 15:25:26 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDD8D@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: RE: How to optimize routing performance
Date: Thu, 15 Mar 2001 15:16:21 -0500
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Or are you saying that the bottleneck is somewhere
> > else completely,
> 
> Indeed. The bottleneck is with processing the incoming network
> packets, at the interrupt level.

Where is the counter for these dropped packets?  If we run a few mbit of
traffic through the box, we see noticeble percentages of lost packets (via
stats from the Ixia traffic generator).  But where in Linux are these counts
stored?  ifconfig does not appear to have the #.

Cheers!
Jon
