Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbRGLAHx>; Wed, 11 Jul 2001 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267378AbRGLAHm>; Wed, 11 Jul 2001 20:07:42 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:5834 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S267308AbRGLAHa>; Wed, 11 Jul 2001 20:07:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Hardware testing [was Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))]
Date: Wed, 11 Jul 2001 11:05:19 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01071011282504.00634@localhost.localdomain> <20010711111159.A2026@suse.cz>
In-Reply-To: <20010711111159.A2026@suse.cz>
MIME-Version: 1.0
Message-Id: <01071111051902.02490@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 July 2001 05:11, Vojtech Pavlik wrote:

> Don't forget the L1/L2/L3 caches. I had once a mainboard with a faulty
> L2 cache chip ('twas a K6-3 CPU, plus a FIC VA-503+ mainboard). No memory
> or CPU test found the failure, yet kernel compliation was still crashing
> after 6-8 hours.
>
> I modified the 'memtest.c' little proggy (not the big memtest86, just a
> little utility that runs under Linux), to use patterns and test size
> that tests the L1 and then L2, and the error has shown after ten seconds
> of running the test.

I don't suppose you still have that lying around somewhere? :)

Rob
