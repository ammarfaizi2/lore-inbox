Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291659AbSBHRTU>; Fri, 8 Feb 2002 12:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSBHRTK>; Fri, 8 Feb 2002 12:19:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291659AbSBHRS5>; Fri, 8 Feb 2002 12:18:57 -0500
Date: Fri, 8 Feb 2002 10:28:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Wirth <Martin.Wirth@dlr.de>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
        <akpm@zip.com.au>, <mingo@elte.hu>, <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C638DB2.460179C0@dlr.de>
Message-ID: <Pine.LNX.4.33.0202081027070.2672-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now, before we go further, can people explain _why_ we want this?

If something is getting a lot of short contention as a semaphore, maybe
it's just broken locking. Let's not work around it with a new locking
primitive just because we can.

What is the _existing_ problem this is trying to solve, and why?

		Linus

