Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRLAWDp>; Sat, 1 Dec 2001 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281773AbRLAWDf>; Sat, 1 Dec 2001 17:03:35 -0500
Received: from druid.if.uj.edu.pl ([149.156.64.221]:15620 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S281772AbRLAWDW>; Sat, 1 Dec 2001 17:03:22 -0500
Date: Sat, 1 Dec 2001 23:03:11 +0100 (CET)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [OT] Wrapping memory.
Message-ID: <Pine.LNX.4.33.0112012249440.15977-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a pseudo-on-topic question:

I would like to have a 64 KBarray (of char), that's trivial, however what
I would like is for the last 4 KB [yes thankfully this is exactly one
page... (assume i386)] to reference the same physical memory as the first
four.

I.e. 16 4KB pages referencing physical 4 KB pages number 0..14, 0.

Is this at all possible? If so, how would I do this in user space (and
could it be done without root priv?)?

Thanks a lot,

Maciej Zenczykowski.

P.S. Yes, this is necessary, otherwise I have to give up on 32-bit access
(switch to 8-bit) and include mod 60KB in every memory access (very random
and I don't think I could predict when no to do this...]

