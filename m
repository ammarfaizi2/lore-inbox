Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131596AbRASMt7>; Fri, 19 Jan 2001 07:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRASMtj>; Fri, 19 Jan 2001 07:49:39 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:56179 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S131332AbRASMth>;
	Fri, 19 Jan 2001 07:49:37 -0500
Date: Fri, 19 Jan 2001 13:49:28 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: More filesystem corruption under 2.4.1-pre8 and SW Raid5
In-Reply-To: <3A682C3C.B0F7E67E@colorfullife.com>
Message-Id: <Pine.LNX.4.30.0101191342220.30906-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Jan 2001, Manfred Spraul wrote:

>
> I don't see a corruption - neither with 192MB ram nor with 48 MB ram.
> SMP, no SW Raid, ext2, but only 1024 byte/file and only 12500
> files/directory.
>
>
> >
> > With 10000 I also had no problem, my next step was 50000.
> >
> 10000 files need ~180MB, that fit's into the cache.
> 50000 files need ~900MB, that doesn't fit into the cache.
>
> I'd try 10000 files, but now with "mem=64m"
>
You are right! I first tried with 20000 files and 256MB and it was ok.
Then I tried with 10000 files and "mem=64m" and I get the corruption.

So if I conclude correctly: we both have SMP + ext2 and you do not have
SW raid and I do, that its definetly a SW raid bug?

Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
