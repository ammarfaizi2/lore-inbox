Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbREHIX4>; Tue, 8 May 2001 04:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbREHIXq>; Tue, 8 May 2001 04:23:46 -0400
Received: from www.sinfopragma.it ([213.26.181.2]:2825 "EHLO
	sinfo-www-01.sinfopragma.it") by vger.kernel.org with ESMTP
	id <S131638AbREHIX3>; Tue, 8 May 2001 04:23:29 -0400
Date: Tue, 8 May 2001 10:16:12 +0200 (W. Europe Daylight Time)
From: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Lorenzo Marcantonio <lomarcan@tin.it>, Rob Turk <r.turk@chello.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10105080904010.24912-100000@callisto.of.borg>
Message-ID: <Pine.WNT.4.31.0105081012030.323-100000@pc209.sinfopragma.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Geert Uytterhoeven wrote:

> In the mean time I down/upgraded to 2.2.17 on my PPC box (CHRP LongTrail,
> Sym53c875, HP C5136A  DDS1) and I can confirm that the problem does not happen
> under 2.2.17 neither.
>
> My experiences:
>   - reading works fine, writing doesn't

Same here

>   - 2.2.x works fine, 2.4.x doesn't (at least since 2.4.0-test1-ac10)

SAME here

>   - hardware compression doesn't matter

SAME HERE

>   - I have a sym53c875, Lorenzo has an Adaptec, so most likely it's not a
>     SCSI hardware driver bug
>   - I have a PPC, Lorenzo doesn't, so it's not CPU-specific
>   - corruption is always a block of 32 bytes being replaced by 32 bytes from
>     the previous tape block (depending on block size!) (approx. 6 errors per
>     256 MB)

YESSS... EXACTLY 32 consecutive bytes are different. I'll bet we've got
the same problem

>   - How many successive bytes are corrupted?
>   - Where do the corrupted data come from?


Hmmmm.... I'll set up some sort of binary pattern match. This afternoon
I'll pinpoint the source of the rogue bytes...


				-- Lorenzo Marcantonio


