Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTA1CJE>; Mon, 27 Jan 2003 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTA1CJE>; Mon, 27 Jan 2003 21:09:04 -0500
Received: from potnoodle.l-w.net ([198.161.91.10]:24290 "EHLO
	potnoodle.l-w.net") by vger.kernel.org with ESMTP
	id <S264815AbTA1CJE>; Mon, 27 Jan 2003 21:09:04 -0500
Date: Mon, 27 Jan 2003 19:25:08 -0700 (MST)
From: lost@l-w.net
To: "David S. Miller" <davem@redhat.com>
Cc: andersg@0x63.nu, lkernel2003@tuxers.net, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
 through Cisco PIX
In-Reply-To: <20030127.143625.84825692.davem@redhat.com>
Message-ID: <Pine.LNX.4.51.0301271920480.27582@potnoodle.l-w.net>
References: <Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us>
 <20030127.101128.104592362.davem@redhat.com> <20030127182856.GE20701@h55p111.delphi.afb.lu.se>
 <20030127.143625.84825692.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, David S. Miller wrote:

> Hey guys, can you all see if this patch makes the problem go away in
> 2.5.x?  It is merely a guess, but it is worth enough to experiment.
>
> Alexey, this piece of code was buggy first time it was coded, and it
> may still have some holes. :-)))

It seems to have cleared up the problem for me. I've been running an SSH
seesion for the past hour without any lock up problems with the patch
installed. Without it, the lock up happened quite reliably within a few
minutes.

William Astle
finger lost@l-w.net for further information

Geek Code V3.12: GCS/M/S d- s+:+ !a C++ UL++++$ P++ L+++ !E W++ !N w--- !O
!M PS PE V-- Y+ PGP t+@ 5++ X !R tv+@ b+++@ !DI D? G e++ h+ y?
