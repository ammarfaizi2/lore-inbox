Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSJFTvg>; Sun, 6 Oct 2002 15:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbSJFTvg>; Sun, 6 Oct 2002 15:51:36 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:44779 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262158AbSJFTvf> convert rfc822-to-8bit; Sun, 6 Oct 2002 15:51:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
Date: Sun, 6 Oct 2002 21:56:43 +0200
X-Mailer: KMail [version 1.4]
References: <200210061608.51459.jan-hinnerk_reichert@hamburg.de> <1033921540.21282.2.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1033921540.21282.2.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210062156.43637.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 6. Oktober 2002 18:25 schrieb Alan Cox:
> On Sun, 2002-10-06 at 15:08, Jan-Hinnerk Reichert wrote:
> > I have 2.4.19 without any patches, three ide harddrives, no CD-ROM.
> > I quite like the data on my machine, so I won't install an 2.4.20-pre on
> > it ;-(
>
> 2.4.20pre has the same IDE code as 2.4.19, plus some PCI layer not IDE
> layer changes to support i845 systems

Thanks, I didn't knew that.

Anyway, could the new PCI layer increase IDE-DMA stability on systems other 
than i845?

BTW: I forgot to mention that I have an PIIX3 board with K5PR166 .

PIIX3 has been somewhat shaky through the whole 2.4 kernel series, but the DMA 
timeouts I get on my machine with 2.4.19 are significantly less than with 
2.4.17 (only one every few days). The non-DMA transferrate has also increased 
to normal levels.

-----------

I have again taken a look at the changelog for 2.4.20-pre8-ac1. It has some 
entries related to IDE. Some are cleanups, some are DMA related.

So how are the chances that things get better or worse, when switching to 
2.4.20?

Is there anything I can do to help tracking this error down, without diving 
too deep into the kernel sources?

One crash every month is acceptable for me (much better than any M$-experience 
I ever had), but somehow it is not satisfying ;-(

 Jan-Hinnerk

