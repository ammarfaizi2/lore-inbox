Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUDXPYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUDXPYs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUDXPYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 11:24:48 -0400
Received: from outmx002.isp.belgacom.be ([195.238.3.52]:464 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262347AbUDXPYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 11:24:46 -0400
Subject: RE:IDE throughput in 2.6 - it's good!
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082820563.2268.10.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Apr 2004 17:29:23 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx002.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken,

	AFAICS, some hdparm -t or dbench 1 will reveal slight variations
between 2.4 & 2.6 ... In some cases 2.4 will be better.

	Running dbench 10 we have :

2.6
202 48.57
234 22.28
234 16.00
234 12.48
234 10.23
234 8.66
234 7.52
431 12.37
463 11.86
464 10.76

2.4.21
119 15.06
151 10.75
282 15.54
301 13.44
313 11.84
352 11.49
360 10.38
360 9.29
360 8.42

	Here's what we can call a server direction.2.6 is unbeatable there due
to IO scheduler (i.e. As-iosched, cfq and noop rock'n'roll)

	There are no good conclusions at all although ,at this state of
development, IMHO, 2.4 seems more 'client friendly' and 2.6 server
oriented in this chapter.

Regards,
FabF

