Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSBISSH>; Sat, 9 Feb 2002 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289099AbSBISR4>; Sat, 9 Feb 2002 13:17:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3846 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S287408AbSBISRs>; Sat, 9 Feb 2002 13:17:48 -0500
Date: Sat, 9 Feb 2002 13:15:47 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.4.33L2.0202060758340.18426-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1020209131301.23246B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Randy.Dunlap wrote:

> I still prefer your suggestion to append it to the kernel image
> as __initdata so that it's discarded from memory but can be
> read with some tool(s).

The problem is that it make the kernel image larger, which lives in /boot
on many systems. Putting it in a module directory, even if not a module,
would be a better place for creative boot methods, of which there are
many.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

