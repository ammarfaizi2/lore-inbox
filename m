Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSLULwg>; Sat, 21 Dec 2002 06:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSLULwg>; Sat, 21 Dec 2002 06:52:36 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:1764 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266898AbSLULwg>;
	Sat, 21 Dec 2002 06:52:36 -0500
Date: Sat, 21 Dec 2002 13:00:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Patrick Petermair <black666@inode.at>
Cc: Vojtech Pavlik <vojtech@suse.cz>, John Reiser <jreiser@BitWagon.com>,
       AnonimoVeneziano <voloterreno@tin.it>,
       Roland Quast <rquast@hotshed.com>, linux-kernel@vger.kernel.org
Subject: Re: vt8235 fix, hopefully last variant
Message-ID: <20021221130024.A29290@ucw.cz>
References: <20021219112640.A21164@ucw.cz> <200212202112.58475.black666@inode.at> <20021221102100.B29004@ucw.cz> <200212211151.50991.black666@inode.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212211151.50991.black666@inode.at>; from black666@inode.at on Sat, Dec 21, 2002 at 11:51:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2002 at 11:51:50AM +0100, Patrick Petermair wrote:
> Vojtech Pavlik:
> 
> > > starbase:/usr/src/linux-2.4.20# patch -p1 < vt8235-atapi
> > > patching file drivers/ide/via82cxxx.c
> > > Hunk #1 FAILED at 1.
> > > Hunk #2 FAILED at 141.
> > > Hunk #3 succeeded at 283 (offset -57 lines).
> > > 2 out of 3 hunks FAILED -- saving rejects to file
> > > starbase:/usr/src/linux-2.4.20#
> >
> > Since they're in comments only, you can ignore them.
> >
> > Can you please try even when the first two hunks failed? Only the
> > third one really matters.
> 
> I patched the clean 2.4.20 source and it boots just fine after 
> compiling. DMA works fine too.
> It's now my default kernel so I'll test it a bit more....

Thanks a lot for the report. If it keeps working, I'll send the patch to
Marcello.

-- 
Vojtech Pavlik
SuSE Labs
