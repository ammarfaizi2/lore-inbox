Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSANAJ2>; Sun, 13 Jan 2002 19:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288364AbSANAJQ>; Sun, 13 Jan 2002 19:09:16 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:40914 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288360AbSANAJG>; Sun, 13 Jan 2002 19:09:06 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] update: preemptive kernel for O(1) sched
Date: Mon, 14 Jan 2002 01:07:52 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200201132325.g0DNPrm05503@zero.tech9.net> <1010965697.813.25.camel@phantasy>
In-Reply-To: <1010965697.813.25.camel@phantasy>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114000911Z288360-13996+5191@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14. January 2002 00:48, you wrote:
> On Sun, 2002-01-13 at 18:22, Dieter Nützel wrote:
> > what about lock-break?
> > I am running your former one as always with
> > lock-break-rml-2.4.18-pre1-1.patch ...;-)
>
> I haven't tested O(1) together with lock-break personally, yet, but I
> have a confirmation of success from a couple of users.  There are no
> reasons it shouldn't work.

I'll say that I am running this altogether.
Only vm-22 or rmap-11 are missing for now.
2.4.17 was running for me with vm-21 and preempt+look-beak.

> > Any success together with AA vm-22?
>
> Again I don't have any personal tests.  I do know, however, the Rik's
> rmap VM works great.

AA, too . Best throughput I've ever seen.

> I suspect Andrea's updated VM from -aa will work, but there may be other
> parts of his patch (RCU) that are not preempt friendly.

But I've only used the VM parts not RCU, etc.

> > What about latencytest0.42-png for latency testing?
>
> A good test.

Expect some numbers (latency) for O(1) with and without preempt+lock-break 
maybe with AA-VM, soon.

-Dieter
