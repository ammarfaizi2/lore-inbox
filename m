Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSEYUSf>; Sat, 25 May 2002 16:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSEYUSe>; Sat, 25 May 2002 16:18:34 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:46858 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315285AbSEYUSd>; Sat, 25 May 2002 16:18:33 -0400
Date: Sat, 25 May 2002 22:18:26 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Michail Rusinov <one@da.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PS/2 keyboard doesn't word with kernel 2.5.17
Message-ID: <20020525201826.GC12761@louise.pinerecords.com>
In-Reply-To: <4710249027.20020525214701@da.ru> <1313922740.20020526005224@da.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 2 days, 23:21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried kernel 2.5.17, and I can't get my PS/2 keyboard to work with
> it. After booting, i can see login prompt, can move my mouse, but I can't
> write anything with my keyboard.
> I used kernel 2.4.18 before, and everything was fine.
> I have Soltek's motherboard (SL-75DRV4 on VIA KT266A).

ACPI has been known to break keyboard code on VIA systems (and maybe
others) in 2.5. Try booting with acpi=off or recompile w/ CONFIG_ACPI=N.

T.
