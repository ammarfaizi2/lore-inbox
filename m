Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbRGFMrm>; Fri, 6 Jul 2001 08:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266681AbRGFMrc>; Fri, 6 Jul 2001 08:47:32 -0400
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:64013 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S266679AbRGFMrW>;
	Fri, 6 Jul 2001 08:47:22 -0400
Date: Fri, 6 Jul 2001 14:47:00 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: "Gregory (Grisha) Trubetskoy" <grisha@ispol.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: reading/writing CMOS beyond 256 bytes?
In-Reply-To: <Pine.BSF.4.32.0107060829460.47924-100000@localhost>
Message-ID: <Pine.LNX.4.33.0107061446240.12127-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Gregory (Grisha) Trubetskoy wrote:

> I wrote a little brogram to read/write the CMOS settings to a file on an
> Intel L440GX motherboard using the outb() to ports 0x70 and 0x71. The idea
> is to save the BIOS settings I like and then be able to blast them from
> within Linux without having to tinker with BIOS setup.
>
> Unfortunately, it seems that some settings are not in the 128 (or 256)
> bytes accessible this way, so they must be stored elsewhere.

the L440GX has a lot of stuff attached to ipmi. Perhaps some of it is
stored there? Just a thought.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


