Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVFMWas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVFMWas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFMW2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:28:25 -0400
Received: from mail.timesys.com ([65.117.135.102]:38525 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261558AbVFMW1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:27:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Attempted summary of "RT patch acceptance" thread
Date: Mon, 13 Jun 2005 18:20:10 -0400
Message-ID: <3D848382FB72E249812901444C6BDB1D01588198@exchange.timesys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Attempted summary of "RT patch acceptance" thread
thread-index: AcVwYh7MpuHgX1NaS/m6LLX5HCjYKgAA4ghQ
From: "Saksena, Manas" <Manas.Saksena@timesys.com>
To: <karim@opersys.com>, <dwalker@mvista.com>
Cc: <paulmck@us.ibm.com>, "Andrea Arcangeli" <andrea@suse.de>,
       "Bill Huey" <bhuey@lnxw.com>, "Lee Revell" <rlrevell@joe-job.com>,
       "Tim Bird" <tim.bird@am.sony.com>, <linux-kernel@vger.kernel.org>,
       <tglx@linutronix.de>, <mingo@elte.hu>, <pmarques@grupopie.com>,
       <bruce@andrew.cmu.edu>, <nickpiggin@yahoo.com.au>, <ak@muc.de>,
       <sdietrich@mvista.com>, <hch@infradead.org>, <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> In essence, what you ask can only hold if all kernel developers
> intend for Linux to become QNX. Clearly this isn't going to happen.

The needs that Linux and QNX (or, whatever your favorite RTOS is)
fulfill are not that separate. 

Keep in mind that Linux has been making inroads into traditional
RTOS markets for 4+ years. RTOSes have been used in many devices
and systems -- many of which do not need the "ruby/diamond" hard
variety of real-time -- preempt-rt would be hard-enough for a 
very large number of devices/systems that currently use an RTOS
(or non mainline Linux kernel). 

> From my point of view, determinism and best overall performance are
> conflicting goals. 

And, likewise SMP and large system scalability will often conflict
with desktop performance. Or, interactive performance goals conflict
with server throughput goals, and so on.... 

> Having separate derectories for something as
> fundamentally different from best overall performance as determinism
> is not too much to ask.   

It probably is too much to ask. In the end, it may very well be the 
case that some capabilities will naturally be partitioned into separate 
directories, but I don't think we are there yet. 

Manas
