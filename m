Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbSKHAaI>; Thu, 7 Nov 2002 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266689AbSKHAaI>; Thu, 7 Nov 2002 19:30:08 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:10760 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S266688AbSKHAaH>; Thu, 7 Nov 2002 19:30:07 -0500
Message-ID: <YWxhbg==.5c396bf3e8e65dc7442a4adb6f35702e@1036715544.cotse.net>
Date: Thu, 7 Nov 2002 19:32:24 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
From: "Alan Willis" <alan@cotse.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why?  We are preempting during the generic file write/read routines, I
> bet, which can otherwise be long periods of latency.  CPU is up and I
> bet the throughput is down, but his test is getting the attention it
> wants.

  I'm curious, would running contest after a fresh boot and with profile=2
provide a profile that tells exactly where time is being spent?  Since
about 2.5.45 I've had some strange slow periods, and starting aterm
would take a while, redrawing windows in X would slow down, it 'feels'
like my workstation becomes a laptop that is just waking up.  Sometimes
this is after only a few minutes of inactivity, or after switching
virtual desktops in kde, or when I have alot of aterm instances running.
 Normal activity for me involves untarring and compiling lots of
software on a regular basis, on a 1.2Ghz celeron and 256mb of mem.  I'm
using 2.5.46+reiser4 patches at the moment.  I'll boot to 2.5.46-mm1
shortly, but I'd love to use reiser4 with akpm's tree though.

Would oprofile help figure out why aterm gets so effing slow at times?
I guess I need to sit down and figure out how to use it.

-alan


