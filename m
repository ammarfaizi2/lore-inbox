Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSEUSHD>; Tue, 21 May 2002 14:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEUSHD>; Tue, 21 May 2002 14:07:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20231 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315406AbSEUSG6>; Tue, 21 May 2002 14:06:58 -0400
Date: Tue, 21 May 2002 14:03:17 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Michael Hoennig <michael@hostsharing.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <20020520231526.12e24b48.michael@hostsharing.net>
Message-ID: <Pine.LNX.3.96.1020521135800.1427B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Michael Hoennig wrote:

> Anyway, when I find time in the next weeks, I will try this patch and post
> it.  I will do it as a mount option.  Nobody is forced to use it ;-)

If I might offer a suggestion, that requires a patched mount command, etc.
I would offer as an alternative implementation which might be both easier
to do and more useful in testing. Make the capability an option in the
kernel, and then require that it be enabled in /proc/sys with default off.
Think TCP_SYN_COOKIES or similar. That way you can have a single patch set
for the kernel only, and no one can possibly "stumble on it" and complain.
Also, you can disable without reboot or remount after testing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

