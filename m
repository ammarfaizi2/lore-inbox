Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUAGWmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUAGWmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:42:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32012 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262353AbUAGWmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:42:09 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0 NFS-server low to 0 performance
Date: 7 Jan 2004 22:30:05 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bti19d$7fn$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange> <Pine.LNX.4.44.0401071431520.479-100000@poirot.grange>
X-Trace: gatekeeper.tmr.com 1073514605 7671 192.168.12.62 (7 Jan 2004 22:30:05 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0401071431520.479-100000@poirot.grange>,
Guennadi Liakhovetski  <g.liakhovetski@gmx.de> wrote:
| On Tue, 6 Jan 2004, Guennadi Liakhovetski wrote:
| 
| > server with 2.6.0 kernel:
| >
| > fast:2.6.0-test11	2m21s (*)
| > fast:2.4.20		16.5s
| > SA1100:2.4		never finishes (*)
| > PXA:2.4.21-rmk1-pxa1	as above
| > PXA:2.6.0-rmk1-pxa	as above
| >
| > server: 2.4.21
| >
| > fast:2.6.0-test11	6s
| > fast:2.4.20		5s
| > SA1100:2.4.19-rmk7	3.22s
| > PXA:2.4.21-rmk1-pxa1	7s
| > PXA:2.6.0-rmk2-pxa	1) 50s (**)
| > (***)			2) 27s (**)
| 
| s/fast/PC2/
| 
| Further, I tried the old 3c59x card - same problems persist. Also tried
| PC2 as the server - same. nfs-utils version 1.0.6 (Debian Sarge). I sent a
| copy of the yesterday's email + new details to nfs@lists.sourceforge.net,
| netdev@oss.sgi.com, linux-net@vger.kernel.org.
| 
| Strange, that nobody is seeing this problem, but it looks pretty bad here.
| Unless I missed some necessary update somewhere? The only one that seemed
| relevant - nfs-utils on the server(s) from Documentation/Changes I
| checked.

I'm sure you checked this, but does mii-tool show that you have
negotiated the proper connection to the hub or switch? I found that my
3cXXX and eepro100 cards were negotiating half duplex with the switches
and cable modems, causing the throughput to go forth and conjugate the
verb "to suck" until I fixed it.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
