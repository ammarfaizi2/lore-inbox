Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSGOQap>; Mon, 15 Jul 2002 12:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSGOQao>; Mon, 15 Jul 2002 12:30:44 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:13477 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317534AbSGOQam>; Mon, 15 Jul 2002 12:30:42 -0400
Message-ID: <3D32F959.A43EFA72@nortelnetworks.com>
Date: Mon, 15 Jul 2002 12:33:29 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sandy Harris <pashley@storm.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch[ Simple Topology API
References: <p73ofdbv1a4.fsf@oldwotan.suse.de>
			<Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
			<20020714214334.A16892@wotan.suse.de> <m1k7nxpvlg.fsf@frodo.biederman.org> <3D32E97A.AD808E43@storm.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris wrote:

> I suspect latency may become an issue when more than one link is
> involved and there can be contention.

According to the AMD talk at OLS, worst case on a 4-way is better than current
best-case on a uniprocessor athlon.

> Beyond 8-way, you need glue logic (hypertransport switches?) and
> latency seems bound to become an issue.

Nope.  Just extend the ladder.  Each cpu talks to three other entities, either
cpu or I/O.  Can be extended arbitrarily until latencies are too high.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
