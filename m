Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315850AbSEGPAE>; Tue, 7 May 2002 11:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315851AbSEGPAD>; Tue, 7 May 2002 11:00:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52939 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315850AbSEGPAC>; Tue, 7 May 2002 11:00:02 -0400
Date: Tue, 7 May 2002 16:59:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Message-ID: <Pine.SOL.4.30.0205071655340.29509-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Roman Zippel wrote:
> > > Another thing: where is the equivalilent part of this removed code?
> > Look closer it's there in ide-probe.c.
>
> Does it still take the correct byte swapping into account?
> Did you consider using a table for the fixup? It's nothing perfomance
> critical and this might generate more compact code.

table can be used but it is harder to maintain,
if you convert it to table please use __le*_top_cpu() macros

--
bkz

