Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUBWWSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUBWWR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:17:27 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:52231 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S262083AbUBWWRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:17:13 -0500
Date: Mon, 23 Feb 2004 17:17:10 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0402231122150.446245-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0402231715010.488941-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


more graphs, and more graphs.

http://depot.mtholyoke.edu:8080/tmp/must-mhc/2002-02-23_17:00/

The monitoring machine, must, had until noon been up for 223 days,
running kernel 2.4.20.  I ping'd 'mhc' from must this morning, and
consistently recieved a response time of 0.2 ms.  It is using the 3c59x
module, w/ a 3c905C-TX card.

options 3c59x options=4 full_duplex=1

Just before noon, I compiled 2.4.24 on must.  Everything else is the
same, except I started running smokeping.

Now, these graphs aren't really long enough to reliably indicate a
trend.  But so far, they are showing ever increasing mhc ping reponse
times.  The same trend can be seen for other machines being monitored.

I plan to let this run this way for awhile.  Then I will boot back to
2.4.20 for comparison.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

