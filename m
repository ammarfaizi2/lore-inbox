Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSHRLOp>; Sun, 18 Aug 2002 07:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSHRLOp>; Sun, 18 Aug 2002 07:14:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64719 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314149AbSHRLOp>;
	Sun, 18 Aug 2002 07:14:45 -0400
Date: Sun, 18 Aug 2002 13:15:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Altaparmakov <aia21@cantab.net>, alan@lxorguk.ukuu.org,
       andre@linux-ide.org, axboe@suse.de, vojtech@suse.cz, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020818131515.A15547@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 16, 2002 at 05:10:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 05:10:12PM -0700, Linus Torvalds wrote:

> On Sat, 17 Aug 2002, Anton Altaparmakov wrote:
> > 
> > Out of curiosity, who is going to be IDE 2.5 kernel maintainer now?
> 
> Well, as I implied, Alan seems to be not completely unwilling to work on 
> it, and unlike me he _can_ interact with Andre most of the time. Possibly 
> Jens will do the 2.5.x side, of it (with Alan working on 2.4), but we've 
> not talked it through.
> 
> I'd like Vojtech to be a bit involved too, he seemed to do some
> much-needed cleanups for PIIX4 IDE (now gone, since we couldn't save just
> those parts..)

I'll make patches for 2.5 to bring the low-level driver cleanups back.
Not just piix.c - also aec62xx.c and amd74xx.c - the last one was in 2.5
for a LONG time already and I'm not particularly happy it got lost.

If desirable (What's your opinion, Alan?) I can make equivalent patches
for 2.4 as well.

-- 
Vojtech Pavlik
SuSE Labs
