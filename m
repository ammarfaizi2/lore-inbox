Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbRFCNqY>; Sun, 3 Jun 2001 09:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263015AbRFCNqE>; Sun, 3 Jun 2001 09:46:04 -0400
Received: from 107bus25.tampabay.rr.com ([24.94.107.25]:10544 "EHLO
	thing2.opinicus.com") by vger.kernel.org with ESMTP
	id <S263012AbRFCNqA>; Sun, 3 Jun 2001 09:46:00 -0400
Date: Sun, 3 Jun 2001 10:38:34 -0400 (EDT)
From: William Montgomery <william@opinicus.com>
To: linux-kernel@vger.kernel.org
Subject: lowlatency 2.2.19
Message-ID: <Pine.LNX.3.96.1010603103738.31484A-100000@thing2.opinicus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am testing Ingo's lowlatency patch on the 2.2.19 kernel and have
a strange problem.  I applied the most recent patch I could find, 
lowlatency-2.2.16-A0 and fixed a few failed hunks.  The kernel appears
stable after many (~24) hours of stress testing with Benno's latencytest
suite and others.  The scheduling jitter is usually under 1msec with
spikes up to 2.5msec on my system - UP PIII 700MHz, 129MRam, 20G SCSI.

In order to locate the spikes I built another kernel; applying Andrea's
ikd patch.  I applied the most recent I could find, 2.2.18pre15aa1-ikd1
and fixed a few failed hunks.  I then applied the lowlatency patch over
that and started testing.  Strangely, the big spikes dissappeared.  Either
the ikd patch has fixed some kernel latency or the timing has changed to
obscure longer latency paths through the kernel.  Again the testing
was performed continuously over a 24 hour period and this time no spikes
over 1msec were observed.

Anyone have any ideas?  

Wm


