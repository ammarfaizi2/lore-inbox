Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268810AbTBZQ0C>; Wed, 26 Feb 2003 11:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268811AbTBZQ0C>; Wed, 26 Feb 2003 11:26:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24120 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268810AbTBZQ0B>; Wed, 26 Feb 2003 11:26:01 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302261636.h1QGaAv21387@devserv.devel.redhat.com>
Subject: Re: Tighten up serverworks workaround.
To: davej@codemonkey.org.uk (Dave Jones)
Date: Wed, 26 Feb 2003 11:36:10 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030226162944.GA15163@codemonkey.org.uk> from "Dave Jones" at Feb 26, 2003 04:29:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've reports of people with rev6's who have reported success
> with that workaround commented out.  Could be they never
> pushed the machine hard enough to trigger a bug, but I'd
> have thought this breakage would show up pretty quickly.

It doesn't. It requires the right patterns and took Dell quite
some time to identify and pin down. If its like the 450NX one
which I suspect it is then you have to have pending misordered
stores to a write gathering target evicted by another read.

> My attempts to contact serverworks in the past have fallen on
> deaf ears. maybe you have better luck ?

I'll try. I got on ok with them for the OSB4 stuff but thats
a long time ago and they've been eaten since then

[Bcc'd to the person I suspect is the right starting point]

Alan
