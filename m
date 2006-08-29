Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWH2ThJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWH2ThJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWH2ThI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:37:08 -0400
Received: from Powered.by.Root24.be ([81.169.180.23]:30948 "EHLO root24.de")
	by vger.kernel.org with ESMTP id S1751204AbWH2ThG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:37:06 -0400
From: =?iso-8859-1?Q?J=F6rg_Hoffmann?= <jh2000@root24.eu>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/net/tcp information drop
Date: Tue, 29 Aug 2006 21:36:54 +0200
Organization: Root24
Message-ID: <000201c6cba2$7c6bae10$2000a8c0@jhnotebook>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <Pine.LNX.4.61.0608292117320.5502@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone (yes, i´m new at this list, just correct me if i´m wrong),

I have some trouble with /proc/net/tcp and tcp6
I´m not sure if it’s a feature or a bug or maybe some cleanup of the
cache...

A long time After a connection has been established the information about
the process name and the pid itself gets lost, just a - appears.
My own network-monitoring tool uses netstat to get some information about
the network-connections. But without the pid I can't see (I could over a few
more corners but ... crap) if there are more programs at the same pid or
even which program it is (maybe an undetected Trojan or just an user with
more connections then allowed...)
Here's a link to the netstat output
http://netstat.root24.eu/netstat.php?dump=1
And to my connection-statistics (the red colored hosts/ips have no special
meaning/ just shows unresolved/new connections)
http://netstat.root24.eu/connmon.php
Normal there is a Pid and prog name in every line... since the server is
online for about a month and some connections are even so long you can see
some 'holes'

Greetings
Jörg

