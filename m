Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRALV1T>; Fri, 12 Jan 2001 16:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135268AbRALV1K>; Fri, 12 Jan 2001 16:27:10 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:7113
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S129595AbRALV0v>; Fri, 12 Jan 2001 16:26:51 -0500
Date: Fri, 12 Jan 2001 22:26:50 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@tethys.fachschaften.tu-muenchen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <E14H8hl-0004ji-00@the-village.bc.nu>
Message-ID: <Pine.NEB.4.31.0101122220080.3614-100000@tethys.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Alan Cox wrote:

> > I want to see the code to handle the apparent VIA DMA bug. At this point,
> > preferably by just disabling DMA on VIA chipsets or something like that
> > (if it has only gotten worse since 2.2.x, I'm not interested in seeing any
> > experimental patches for it during early 2.4.x).
>
> It hasnt gotten worse, its just its a very specific combination and its a
> well known problem (vendors dont enable auto dma for ide for this reason)
> 2.2.16 just covers the cases I know about (and slightly overdoes it for now)
>
> > We've already had one major fs corruption due to this, I want that fixed
> > _first_.
>
> I've got other reports too.
>...

At least some of the reported problems with VIA chipsets are fixed with
the VIA IDE driver v3.11 [1]. Are there any problems that still occur with
this driver?

cu,
Adrian

[1] http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-02/1291.html


-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
