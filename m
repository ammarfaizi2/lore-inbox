Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282998AbRK1AR3>; Tue, 27 Nov 2001 19:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282989AbRK1ARS>; Tue, 27 Nov 2001 19:17:18 -0500
Received: from ppp37.adsl88.pacific.net.au ([202.7.88.37]:387 "EHLO
	mail.xplantechnology.com") by vger.kernel.org with ESMTP
	id <S282997AbRK1ARB>; Tue, 27 Nov 2001 19:17:01 -0500
Date: Wed, 28 Nov 2001 11:18:16 +1100 (EST)
From: Luke <luked@xplantechnology.com>
X-X-Sender: <luked@oven.xden.xplantechnology.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: threads & /proc
Message-ID: <Pine.LNX.4.33.0111281047450.1245-100000@oven.xden.xplantechnology.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some more data about the problem reported by Anton where "ps",
"top", "killall", etc block and "kill" doesn't work.

I have encountered this behaviour with kernels 2.4.14 and 2.4.16 but not
2.4.13 nor 2.4.7 (although 2.4.13 hung this box in a different way).

This was observed on an SMP Pentium III, which does some multithreaded
computation.

I can't give precise instructions on how to replicate this bug, but
perhaps it can be repeated simply by exercising kernel threading?

Luke.


