Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVAGQYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVAGQYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVAGQYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:24:06 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:17342 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261494AbVAGQWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:22:35 -0500
Message-Id: <200501071622.j07GMUCr018735@localhost.localdomain>
To: Martin Mares <mj@ucw.cz>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 17:03:59 +0100."
             <20050107160359.GA6529@ucw.cz> 
Date: Fri, 07 Jan 2005 11:22:30 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 10:22:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's quite probable that the current system of capabilities is not well
>suited for this, but I think that although it's tempting to work around it
>by introducing a new security module, in the long term it's much better
>to extend and/or fix the capabilities -- I don't see any fundamental reason
>for capabilities being unusable for this goal, it's much more likely to be
>just minor details in the implementation.

capabilities work - we use them in 2.4 where a helper suid application
gets the ball rolling, and then its child grants capabilities to new
clients. 

the problem we have with capabilities is that capabilities are not
enabled by default in the vanilla kernel, and there seems to be
considerable advice suggesting that they should not be enabled.

--p
