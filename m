Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129865AbRB0W4f>; Tue, 27 Feb 2001 17:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbRB0W40>; Tue, 27 Feb 2001 17:56:26 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:16910 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129865AbRB0W4N>;
	Tue, 27 Feb 2001 17:56:13 -0500
Envelope-To: linux-kernel@vger.redhat.com
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102272043.UAA01056@raistlin.arm.linux.org.uk>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: kuznet@ms2.inr.ac.ru
Date: Tue, 27 Feb 2001 20:43:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102272035.XAA21341@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb 27, 2001 11:35:12 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru writes:
> Moreover, even not _one_ wakeup is missing. At least two, because
> wakeups in read and write are separate and you have stuck in both directions.
> 8)8)

I'll see if I can strace it from the start until it hangs tomorrow.

> Well, if it was one I would start to dig ground inside tcp instantly.
> But as soon as two of them are missing, I have to suspect wake_up itself.
> At least, we had such bugs there until 2.4.0.

I was running at one point a 2.4.0-test kernel, but I didn't see these
effects back then (but then I wasn't monitoring the system as closely as
I am at the moment).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

