Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUIKSvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUIKSvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUIKSvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:51:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:24716 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268278AbUIKSvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:51:07 -0400
Date: Sat, 11 Sep 2004 20:50:58 +0200 (MEST)
Message-Id: <200409111850.i8BIowaq013662@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: sashak@smlink.com
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 patch)
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 16:48:56 +0300, SashaK <sashak@smlink.com> wrote:
>On Sat, 11 Sep 2004 12:26:00 +0200 (MEST)
>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
>> I hope you succeed with open-sourcing all of slmodem's driver
>> code. My Targa Athlon64 laptop has the AMR thingy and the
>> 32-bit x86 binary only slmodem driver prevents me from using
>> the modem while running a 64-bit kernel.
>
>You mean to GPL user-space program slmodemd?
>I think it is good idea, but unfortunately this code is not just my, and
>final decision was 'no'.

No, I meant the 'slamr' kernel driver module, which is
built from a big binary-only library (amrlibs.o) and
a small amount of kernel glue source code. As long as
amrlibs.o is distributed only as a 32-bit x86 binary,
I won't be able to use it with a 64-bit amd64 kernel.

slmodemd is not the problem since an amd64 kernel can
support 32-bit x86 user-space binaries.

/Mikael
