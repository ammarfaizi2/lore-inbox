Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288326AbSAMXpf>; Sun, 13 Jan 2002 18:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288325AbSAMXp0>; Sun, 13 Jan 2002 18:45:26 -0500
Received: from zero.tech9.net ([209.61.188.187]:34322 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288327AbSAMXpN> convert rfc822-to-8bit;
	Sun, 13 Jan 2002 18:45:13 -0500
Subject: Re: [PATCH] update: preemptive kernel for O(1) sched
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200201132325.g0DNPrm05503@zero.tech9.net>
In-Reply-To: <200201132325.g0DNPrm05503@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 18:48:17 -0500
Message-Id: <1010965697.813.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 18:22, Dieter Nützel wrote:

> what about lock-break?
> I am running your former one as always with 
> lock-break-rml-2.4.18-pre1-1.patch ...;-)

I haven't tested O(1) together with lock-break personally, yet, but I
have a confirmation of success from a couple of users.  There are no
reasons it shouldn't work.

> Any success together with AA vm-22?

Again I don't have any personal tests.  I do know, however, the Rik's
rmap VM works great.

I suspect Andrea's updated VM from -aa will work, but there may be other
parts of his patch (RCU) that are not preempt friendly.

> What about latencytest0.42-png for latency testing?

A good test.

	Robert Love

