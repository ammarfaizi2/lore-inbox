Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHGUog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHGUog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 16:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUHGUog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 16:44:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53485 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264377AbUHGUoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 16:44:25 -0400
Date: Sat, 7 Aug 2004 22:36:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>,
       wli@holomorphy.com, "David S. Miller" <davem@redhat.com>,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: architectures with their own "config PCMCIA"
In-Reply-To: <200408072013.01168.arnd@arndb.de>
Message-ID: <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org>
 <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Arnd Bergmann wrote:
> > On Sat, Aug 07, 2004 at 06:10:51PM +0100, Christoph Hellwig wrote:
> > > What about switching them to use drivers/Kconfig instead?
>
> I'd prefer not to switch s390 to use drivers/Kconfig unless someone
> volunteers to clean up all included Kconfig files by adding proper
> 'depends on PCI' etc. flags. Otherwise too many broken options are
> offered.

I've been `fixing up' many of them lately. Please give it a try.
Anyway, probably all additional clean ups you do for s390 are useful for m68k
as well ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
