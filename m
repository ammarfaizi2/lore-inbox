Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTEVFgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTEVFgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:36:21 -0400
Received: from tag.witbe.net ([81.88.96.48]:54539 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262494AbTEVFgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:36:19 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
Cc: "'Corey Minyard'" <minyard@acm.org>, <linux-kernel@vger.kernel.org>
Subject: Re: e100 latency, cpu cycle saver and e1000...
Date: Thu, 22 May 2003 07:49:21 +0200
Message-ID: <019c01c32025$e4d2b9c0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.50.0305211848130.25777-100000@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> One thing you can do to reduce packet handling latency (at 
> the cost of 
> CPU) with both the e1000 is drop down the RX Delay Interrupt 
> timers, ditto 
> for the Tx Delay. The hardware delays in increments of 1.024ms
> 
That's right, though the driver is not exhibiting a R/W /proc interface,
which probably means I'll have to reboot the server.

However, what I'm trying to figure out is : why did this latency 
change suddenly, if it can't be related to a CPU Cycle Saver, as
the code doesn't seem to contain something that would allow a dynamic
change of such a parameter on a running machine...

Of course, the problem may be completely unrelated to the NIC,
my initial question being : is there a CPU Cycle Saver on the e1000
as there is one on the e100... ;-)

Regards,
Paul

