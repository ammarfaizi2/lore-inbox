Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314087AbSDQIcc>; Wed, 17 Apr 2002 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314090AbSDQIcb>; Wed, 17 Apr 2002 04:32:31 -0400
Received: from mail.sonytel.be ([193.74.243.200]:17044 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S314087AbSDQIca>;
	Wed, 17 Apr 2002 04:32:30 -0400
Date: Wed, 17 Apr 2002 10:25:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: david.lang@digitalinsight.com, vojtech@suse.cz,
        dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416.100610.115916272.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0204171019530.1258-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, David S. Miller wrote:
>    From: David Lang <david.lang@digitalinsight.com>
>    Date: Tue, 16 Apr 2002 10:09:38 -0700 (PDT)
> 
>    I could be wrong, it's a 2.1.x kernel that they started with. I thought
>    that was around the time the fix went in.
>    
> Again, I did the fix 6 years ago, thats pre-2.0.x days
> 
> EXT2 has been little-endian only with proper byte-swapping support
> across all architectures, since that time.

On SPARC. M68k followed a bit later. But when I got my CHRP board, ext2 was
still big endian on (at least some) PPC boxes, so PPC must have been switched
over in 1997/1998.

I tried to find the exact date of the appearance of the `-s' option of e2fsck
in the changelog og e2fsprogs, but apparently not all changes are mentioned
there.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

