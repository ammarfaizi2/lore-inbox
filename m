Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbTCOJXz>; Sat, 15 Mar 2003 04:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbTCOJXz>; Sat, 15 Mar 2003 04:23:55 -0500
Received: from tag.witbe.net ([81.88.96.48]:25093 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S261357AbTCOJXy>;
	Sat, 15 Mar 2003 04:23:54 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <war@lucidpixels.com>, <adilger@clusterfs.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Broadcom BCM5702 Major Problems
Date: Sat, 15 Mar 2003 10:34:30 +0100
Message-ID: <003801c2ead6$1553f580$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030315054100.20199.qmail@lucidpixels.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have some BCM running pretty well with both IO-APIC and
Local APIC with kernel 2.4.19...

Which one are you talking about ?

Regards,
Paul

> Found the bug.
> Well, for me anyway.
> When I have this configuration option turned on:
> 
> [*] IO-APIC support on uniprocessors
> 
> Everything goes to hell.
> 
> Even the 3COM I stuck in wants to get routed to IRQ 18 and 
> you cannot even force it to use anotheR IRQ.
> 
> This option:
> 
> [*] Local APIC support on uniprocessors
> 
> Works fine.
> 
> It is the second option that royally screws over the system.

