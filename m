Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129871AbRBQAIj>; Fri, 16 Feb 2001 19:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRBQAI3>; Fri, 16 Feb 2001 19:08:29 -0500
Received: from 041imtd176.chartermi.net ([24.247.41.176]:50842 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S129871AbRBQAIN>; Fri, 16 Feb 2001 19:08:13 -0500
Date: Fri, 16 Feb 2001 19:08:05 -0500
From: Simon Kirby <sim@stormix.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 TCP(?) timeouts
Message-ID: <20010216190805.A14603@stormix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Today we put 2.4.1 on our mail server after having see it perform well on
some other boxes.  It seems now we are receiving a few calls every hour
from customers reporting that the server tends to hang and eventually
time out on them when downloading mail.  All customers that have reported
this problem so far are on a didalup connection.  Apparently the server
will stop transmitting data (or the client seems to think so), and then
their mail client will time out.

I noticed that the 2.4.1 on my desktop seems to time out SSH connections
to servers that have become unreachable in about 10 seconds or so, which
is many times faster than 2.2 which used to sit for hours before it timed
out (if it all).  I'm not sure if this is related.  I would expect the
client to attempt to retransmit some ACKs and eventually get some RSTs
back if this were the case.

Has anybody seen similar problems?  The box was previously running
2.2.19pre8 and no customers reported such problems.

We're using cucipop w/ldap on a dual PIII 800 MHz box with 1.5 GB of RAM.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
