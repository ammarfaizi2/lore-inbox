Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUCBOFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 09:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUCBOFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 09:05:51 -0500
Received: from [209.124.87.2] ([209.124.87.2]:12525 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S261648AbUCBOFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 09:05:49 -0500
From: "Steve Lee" <steve@tuxsoft.com>
To: "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.4-rc1 problems with e100 & 3c59x
Date: Tue, 2 Mar 2004 08:05:32 -0600
Message-ID: <008301c4005f$708fec70$e501a8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.58.0403020258110.29087@montezuma.fsmlabs.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using /etc/modprobe.conf and I don't load any modules manually.
This is mostly a module kernel, the only problem I'm having is with the
network.  2.6.3 does work with the drivers compiled in (but not as
modules).  2.6.4-rc1 I can not get to work at all (modules or builtin).
Thanks for your suggestion.

Steve

-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca] 
Sent: Tuesday, March 02, 2004 2:00 AM
To: Steve Lee
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1 problems with e100 & 3c59x

On Mon, 1 Mar 2004, Steve Lee wrote:

> I've searched the archives as well as googled around without any luck
> regarding my situation.  BTW, please CC me as I'm no longer subscribed
> (furthering my education has prevented me from keeping up with the
> list).
>
> Can anyone please give me some clue as to what might be wrong?  My
> network is working fine with the drivers compiled in 2.6.3 (but not as
> modules).  I can't get 2.6.4-rc1 to work at all with my network cards.

One thing to make sure is that you're using /etc/modprobe.conf and don't
load the modules manually.

	Zwane




