Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRFBQsl>; Sat, 2 Jun 2001 12:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRFBQsb>; Sat, 2 Jun 2001 12:48:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:57093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262618AbRFBQs2>; Sat, 2 Jun 2001 12:48:28 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: missing sysrq
Date: 1 Jun 2001 16:13:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9f97hu$83v$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca> <20010601203841Z261493-933+3160@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010601203841Z261493-933+3160@vger.kernel.org>
By author:    Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
In newsgroup: linux.dev.kernel
>
> Am Freitag, 1. Juni 2001 16:51 schrieben Sie:
> > > Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
> > > You need both, compiled in and activation.
> >
> > no, look at the code.  the enable variable defaults to 1.
> 
> Then there must be a bug?
> I get "0" with 2.4.5-ac2 and -ac5 without "echo 1".
> 
> Fresh booted 2.4.5-ac2:
> 
> SunWave1>cat /proc/version
> Linux version 2.4.5-ac2 (root@SunWave1) (gcc version 2.95.2 19991024 
> (release)) #1 Mon May 28 05:42:09 CEST 2001
> SunWave1>cat /proc/sys/kernel/sysrq
> 0
> 

Let me guess... you're using a RedHat system?  RedHat, for some
idiotic reason, defaults to actively turning this off for you (and
they turn Stop-A off on SPARC, too.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
