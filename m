Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSLCBrV>; Mon, 2 Dec 2002 20:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbSLCBrV>; Mon, 2 Dec 2002 20:47:21 -0500
Received: from hitchcock.mail.mindspring.net ([207.69.200.23]:64280 "EHLO
	hitchcock.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265894AbSLCBrU>; Mon, 2 Dec 2002 20:47:20 -0500
Date: Mon, 02 Dec 2002 20:54:50 -0500
From: <joeja@mindspring.com>
To: linux-kernel@vger.kernel.org
Reply-To: joeja@mindspring.com
Subject: iptables mangle
Message-ID: <Springmail.0994.1038880490.0.39019100@webmail.atl.earthlink.net>
X-Originating-IP: 4.20.162.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this should be posted here, but I already asked the people at
netfilter.org and got no reply.  This was a while ago!

I started looking at my firewall rules and running iptables -L -v and also -t
nat -t mangle to see what is being dropped and passed.

It seems that the mangle table is now connected to all 5 tables ( or so the
docs say as of 2.4.18 this changed, I am using 2.4.19 on RH 7.3), so I
modified my rules to take this into account.

I also noticed that there is the REJECT option to -j available to the INPUT,
FORWARD and OUTPUT chains.

Problem is it does not work in the INPUT chain of the mangle table.

Is this a bug or just not implemented yet or do I need a newer version of
iptables?

I have iptables 1.2.6 ( I think it is "1.2.6a" but have to double check on
that).  It works on the INPUT chain of the default filter table, shouldn't it
work on mangle as well?

not on the list:
Thanks
Joe

