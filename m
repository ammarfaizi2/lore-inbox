Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267419AbRHBR0L>; Thu, 2 Aug 2001 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbRHBR0B>; Thu, 2 Aug 2001 13:26:01 -0400
Received: from otter.mbay.net ([206.40.79.2]:6670 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S267419AbRHBRZz> convert rfc822-to-8bit;
	Thu, 2 Aug 2001 13:25:55 -0400
From: jalvo@mbay.net (John Alvord)
To: linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Date: Thu, 02 Aug 2001 17:26:02 GMT
Message-ID: <3b6a8c9b.13382832@mail.mbay.net>
In-Reply-To: <Pine.LNX.4.30.0108020928230.2340-100000@waste.org> <3B698177.C12183CF@mvista.com>
In-Reply-To: <3B698177.C12183CF@mvista.com>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001 09:36:07 -0700, george anzinger
<george@mvista.com> wrote:
 ...
>  The timing
>tests (800MHZ PIII) show the whole setup taking an average of about 1.16
>micro seconds.  the problem is that this happens, under kernel compile,
>~300 times per second, so the numbers add up.  Note that the ticked
>system timer overhead (interrupts, time keeping, timers, the works) is
>about 0.12% of the available cpu.  Under heavy load this raises to about
>0.24% according to my measurments.  The tick less system overhead under
>the same kernel compile load is about 0.12%.  No load is about 0.012%,
>but heavy load can take it to 12% or more, most of this comming from the
>accounting overhead in schedule().  Is it worth it?

I thought the claimed advantage was on certain S/390 configurations
(running 100s of Linux/390 images under VM) where the cost is
multiplied by the number of images. A measurement on another platform
may be interesting but not conclusive.

john alvord
