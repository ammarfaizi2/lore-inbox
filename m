Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSKKBvE>; Sun, 10 Nov 2002 20:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbSKKBvD>; Sun, 10 Nov 2002 20:51:03 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:38531 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265333AbSKKBvD>; Sun, 10 Nov 2002 20:51:03 -0500
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Ben Clifford <benc@hawaga.org.uk>
Subject: Re: [PATCH] 2.5.46: access permission filesystem
Date: Mon, 11 Nov 2002 02:57:34 +0100
In-Reply-To: <Pine.LNX.4.44.0211101609220.2335-200000@barbarella.hawaga.org.uk> (Ben
 Clifford's message of "Sun, 10 Nov 2002 16:11:06 -0800 (PST)")
Message-ID: <87k7jkg969.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Clifford <benc@hawaga.org.uk> writes:

> I still get those stack traces, though...

I retested with CONFIG_PREEMPT=y and now I get those stack traces,
too. So, it seems my code is not preempt safe.

Regards, Olaf.
