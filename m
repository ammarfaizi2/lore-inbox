Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286351AbSAAXNT>; Tue, 1 Jan 2002 18:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286360AbSAAXM7>; Tue, 1 Jan 2002 18:12:59 -0500
Received: from net088s.hetnet.nl ([194.151.104.184]:18694 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S286351AbSAAXMu>;
	Tue, 1 Jan 2002 18:12:50 -0500
Message-Id: <5.1.0.14.2.20020101232500.00a2fc60@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 01 Jan 2002 23:32:40 +0100
To: kuznet@ms2.inr.ac.ru
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: Re: AX25/socket kernel PATCHes
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011230223848.00a2d570@pop.hetnet.nl>
In-Reply-To: <200112301924.WAA24526@ms2.inr.ac.ru>
 <5.1.0.14.2.20011230174733.00a2fc50@pop.hetnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey,

At 23:13 30-12-01 +0100, Henk de Groot wrote:
>At 22:24 30-12-01 +0300, kuznet@ms2.inr.ac.ru wrote:
>>+               if (len < dev->hard_header_len)
>>+                       skb->nh.raw = skb->data;
>
>I'll try that. I'm currently rebuilding the kernel, APM is working lousy on my Compaq 12LX302 laptop so I'm recompiling without APIC to see if that makes a change. Anyway, that takes a while, I'll report back on this.

Okay, APM is still a big mess for this Laptop, but I had a chance to try out the above patch. As expected this at least prevents hitting the "protocol is buggy" message in dev.c. If other people want to try, the file af_packet.c located in net/packet (and not in net/core).

I intent to try to dump this depricated socket use in the application, needs some experimentation and testing. So far so good.

Kind regards,

Henk.

