Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTEUOCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTEUOCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:02:34 -0400
Received: from tag.witbe.net ([81.88.96.48]:776 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261747AbTEUOCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:02:33 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Corey Minyard'" <minyard@acm.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: e100 latency, cpu cycle saver and e1000...
Date: Wed, 21 May 2003 16:15:35 +0200
Message-ID: <011a01c31fa3$725354e0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3ECB87F5.8060808@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> My little program was crude at best.
Yes, I know, but it does exist !

> You have to take into account what the machines are doing.  
> If you notice, the "Min" latency is about the same, so it's 
> not a CPU cycle saver.  The long "Max" latencies mean you 
> probably have something on IP2 that is blocking the execution 
> of the IP stack (for, say up to 4.5ms). 
> Are all the machine completely quiesced except for the test program? 
> Have you tried switching the network connections to see if it 
> is in the network hardware?

Correct, machines are not idle... but 
 - they are doing globally the same work,
 - this behavior is something I can reproduce test after test, since
   I've started this morning...

I started using that because IP1 was exhibiting high latency yesterday
'til I rebooted it, and since it is working quite fine...
Of course, I can reboot also IP2, but I'd like to understand why
and how to avoid it later...

Regards,
Paul

