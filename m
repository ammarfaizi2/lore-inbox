Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263399AbREXHjO>; Thu, 24 May 2001 03:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263400AbREXHjE>; Thu, 24 May 2001 03:39:04 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:27849 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S263399AbREXHi4>; Thu, 24 May 2001 03:38:56 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Srinivasan Venkatraman" <srini@dcs.uky.edu>,
        <linux-kernel@vger.kernel.org>
Subject: RE: How to time in Kernel
Date: Thu, 24 May 2001 00:38:54 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKKEBPPEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.10.10105231237210.13795-100000@lisa.dcs.uky.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  I am trying to time a portion of code inside the kernel. How do I do it?
> Can I use do_gettimeofday ? or do_getitimer ? Any leads will be
> appreciated.

	If this is for personal debugging use only and you have a Pentium or better
x86 processor, I recommend reading the TSC directly. 'msr.h' (in the
asm-i386 include directory) include 'rdtsc' and friends.

	DS

