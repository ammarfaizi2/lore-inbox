Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266841AbUBMJNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUBMJNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:13:18 -0500
Received: from witte.sonytel.be ([80.88.33.193]:61892 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266841AbUBMJNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:13:16 -0500
Date: Fri, 13 Feb 2004 10:13:07 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Urban Widmark <Urban.Widmark@enlight.net>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       JohnNewbigin <jn@it.swin.edu.au>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: smb_ops_unix warning (was: Re: Linux 2.4.25-rc2)
In-Reply-To: <Pine.LNX.4.44.0402121758290.14391-100000@cola.local>
Message-ID: <Pine.GSO.4.58.0402131012330.23784@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402121758290.14391-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Urban Widmark wrote:
> On Thu, 12 Feb 2004, Geert Uytterhoeven wrote:
> > On Wed, 11 Feb 2004, Marcelo Tosatti wrote:
> > > Here goes -rc2, with small number of fixes and corrections.
> >
> > This patch adds a missing include (fortunately it was included in some other
> > include, but its' not clean for files that check CONFIG_* flags) and kills a
> > compiler warning (introduced in -rc1, IIRC) if CONFIG_SMB_UNIX is not set.
>
> Ah, thanks.
>
>
> > Alternatively, perhaps the code can be reshuffled a bit to avoid too many
> > ifdefs?
>
> Code below builds cleanly for me either way, but I have not tested it yet.
> Will do that later.
>
> The config could also be removed, but I like that 2.4 users can keep the
> previous 2.4 behaviour if they want to.

I can confirm it has the same result: no more compiler warnings.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
