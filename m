Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135184AbRA2Q1m>; Mon, 29 Jan 2001 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135321AbRA2Q1d>; Mon, 29 Jan 2001 11:27:33 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:40650
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S135330AbRA2Q1X>; Mon, 29 Jan 2001 11:27:23 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCE5@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'jamal'" <hadi@cyberus.ca>, Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: RE: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Date: Mon, 29 Jan 2001 11:16:56 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Throughput: 100Mbps is really nothing. Linux never had a problem with
> 4-500Mbps file serving. So throughput is an important number. so is
> end to end latency, but in file serving case, latency might 
> not be a big deal so ignore it.

If I try to route more than 40mbps (40% line utilization) through a 100mbps
port (tulip) on a 2.4.0-test kernel running on a pIII 500 (or higher)
system, not only does the performance drop to nearly 0, the system gets all
sluggish and unusable.  This is with or without Jamal's FF patches.

How are you managing to get such high throughput?

Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
