Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTAGGnQ>; Tue, 7 Jan 2003 01:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTAGGnQ>; Tue, 7 Jan 2003 01:43:16 -0500
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:63468 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S267320AbTAGGnP>;
	Tue, 7 Jan 2003 01:43:15 -0500
Date: Tue, 7 Jan 2003 07:51:46 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: Dave Airlie <airlied@linux.ie>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dummy ethernet driver
In-Reply-To: <Pine.LNX.4.44.0301062229330.29921-100000@skynet>
Message-ID: <Pine.LNX.4.44.0301070744430.13867-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Dave Airlie wrote:

> > If you want to talk to local systems why don't you use the netlink
> > interface/ethertap stuff ?
> 
> because I'm unconscionably lazy, and the VAX simulator code is already
> written to use pcap and I'd rather not rewrite it, why fix something when
> a quick hack will suffice :-)

Just as an aside, the ts10 vax emulator uses the tap driver. Combined with
the kernel bridging code you can create all kinds of network
configurations.

The last time i looked at simh Bob Supnik mentioned that the ethernet 
simulation layer was to be targeted at tap/tun driver among others.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


