Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268933AbRHLDER>; Sat, 11 Aug 2001 23:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268936AbRHLDEG>; Sat, 11 Aug 2001 23:04:06 -0400
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:55522 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S268934AbRHLDEA>; Sat, 11 Aug 2001 23:04:00 -0400
Date: Sat, 11 Aug 2001 23:04:11 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Garett Spencley <gspen@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q3A segfaults with 2.4.8
In-Reply-To: <Pine.LNX.4.33L2.0108112137350.17803-100000@localhost.localdomain>
Message-ID: <Pine.A41.4.21L1.0108112254150.14380-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm, I upgraded from 2.4.7-ac11 + EMU10K1 CVS v0.15 diffs to 2.4.8 + Rui's
patch + Juha's AC3 SMP fix + Andrea's 2.4.8aa1, and quake3 1.29h PR works
fine here. I did compile with gcc version 2.95.4 20010721 (Debian pre
release), however.

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Sat, 11 Aug 2001, Garett Spencley wrote:

> I have no idea how to debug this so some insight would be very helpful.
> Quake3 arena is crashing with 2.4.8 and 2.4.8-ac1.
> 
> I'm pretty sure it's related to the emu10k1 changes because the last
> output is:
> 
> ...loading 'scripts/sky.shader'
> ...loading 'scripts/test.shader'
> ----- finished R_Init -----
> 
> ------- sound initialization -------
> ------------------------------------
> Received signal 11, exiting...
> 
> It works fine with 2.4.7 and -ac series.

