Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314144AbSD0OPt>; Sat, 27 Apr 2002 10:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314207AbSD0OPs>; Sat, 27 Apr 2002 10:15:48 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:62444 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S314144AbSD0OPr>;
	Sat, 27 Apr 2002 10:15:47 -0400
Date: Sat, 27 Apr 2002 16:15:35 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204271415.QAA12579@harpo.it.uu.se>
To: dalecki@evision-ventures.com
Subject: Re: PDC20265 / 2.5.10 / Alpha (Miata) - unexpected interrupt flood
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002 13:08:07 +0200, Martin Dalecki wrote:
>> ide: unexpected interrupt 1 44
>Yes. This message has been added. It's harmless.
>It will happen if the interrupt in question is shared
>among different devices for example.

The condition may be harmless, but flooding the kernel log with
these messages most certainly is not. I've experienced that
myself, when testing 2.5.8 on a machine with a PDC20267.
The message needs to go away.

/Mikael
