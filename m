Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSELRCj>; Sun, 12 May 2002 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSELRCi>; Sun, 12 May 2002 13:02:38 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:30984 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S313690AbSELRCh>; Sun, 12 May 2002 13:02:37 -0400
Date: Sun, 12 May 2002 19:02:26 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: <linux-kernel@vger.kernel.org>, <rml@tech9.net>
Subject: Re: [2.4.18] preemptible patch causing freeze
In-Reply-To: <200205121556.RAA02088@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.33.0205121900160.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Mikael Pettersson wrote:

> Are you sure you were using this exact .config without the
> CONFIG_PREEMPT=y in 2.4.18 vanilla? The problem is that recent
> Dell laptops with local APICs are known to have buggy BIOSen
> that cause exactly the kinds of problems you described (hangs
> at BIOS and power-management events).

Aaaaargh. The config was really the same, but I tested the behaviour on
the kernel with APICs disabled (dunno how it happend). The freeze does
take place with 2.4.18 vanilla with APCI enabled.

Sorry for the false alert. Going to try 19pre soon.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

