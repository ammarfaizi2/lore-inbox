Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVLORyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVLORyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVLORyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:54:31 -0500
Received: from witte.sonytel.be ([80.88.33.193]:30714 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750837AbVLORya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:54:30 -0500
Date: Thu, 15 Dec 2005 18:54:17 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
In-Reply-To: <20051215174725.GZ27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0512151850170.6884@pademelon.sonytel.be>
References: <20051215085516.GU27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk>
 <20051215174725.GZ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Al Viro wrote:
> On Thu, Dec 15, 2005 at 05:16:45PM +0000, Al Viro wrote:
> > So who should I put as the author?  You or Geert (or whatever attributions
> > might have been in said big patch)?  Incidentally,  ADBREQ_RAW had leaked
> > into mainline (sans definition) in 2.3.45-pre2, which was Feb 13 2000, i.e.
> > more than 1.5 year before your commit, so there's quite a chunk of history
> > missing...
> > 
> > I'm serious, BTW - I certainly would have no problem preserving attribution,
> > but it simply hadn't been there.  CVS logs are only as good as the data
> > being put there by committers...
> 
> With some archaeology...  It looks like drivers/macintosh part is from
> Geert (with chunks from benh? not sure) circa Dec 2000; adb.h is a missing
> piece of earlier patch (one that had leaked in Feb 2000, $DEITY knowns how
> much older it is)...

Nah, I never did Mac development ;-)

IIRC, this change originally came from maclinux CVS (which predates Linux/m68k
CVS by several years) via email. If you wait a few hours, the original author
probably will start yelling ;-)

Alternatively, I can dig up my email archives from before 2000 to identify
him....

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
