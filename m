Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267708AbTBUVH1>; Fri, 21 Feb 2003 16:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTBUVH1>; Fri, 21 Feb 2003 16:07:27 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267708AbTBUVHY>;
	Fri, 21 Feb 2003 16:07:24 -0500
Date: Sun, 16 Feb 2003 22:32:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.61
Message-ID: <20030216213244.GB2546@elf.ucw.cz>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com> <20030215183555.A22045@infradead.org> <3E4E8AB0.4040600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4E8AB0.4040600@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is Linus really the right person to direct these to?
> 
> 
> >> o use per-cpu data for ia32 profiler
> >
> >
> >any reason you only changed prof_counter to pr-cpu data and not the
> >two NR_CPUS arrays above it?
> >
> >
> >> o acpi: Split i386 support up
> >
> >
> >Shouldn't this be in arch/i386/acpi/ instead of arch/i386/kernel/acpi/
> 
> Agreed, though Pat or Andy G are better people to tell this... it's only 
> a "bk mv" away for either of them :)

*Bad* idea, as it will introduce unneccessary rejects for anyone
having any change to acpi... 
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
