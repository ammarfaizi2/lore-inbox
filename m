Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSJCM0P>; Thu, 3 Oct 2002 08:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263260AbSJCM0L>; Thu, 3 Oct 2002 08:26:11 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:15579 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263256AbSJCM0J>;
	Thu, 3 Oct 2002 08:26:09 -0400
Date: Thu, 3 Oct 2002 14:31:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003143132.A38769@ucw.cz>
References: <20021003141021.A38642@ucw.cz> <Pine.LNX.4.44.0210031427260.14274-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210031427260.14274-100000@boris.prodako.se>; from tori@ringstrom.mine.nu on Thu, Oct 03, 2002 at 02:28:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:28:44PM +0200, Tobias Ringstrom wrote:
> On Thu, 3 Oct 2002, Vojtech Pavlik wrote:
> 
> > On Thu, Oct 03, 2002 at 02:08:26PM +0200, Tobias Ringstrom wrote:
> > > On Thu, 3 Oct 2002, Vojtech Pavlik wrote:
> > > 
> > > > Yes, please try with #I8042_DEBUG_IO enabled, try all the suspicious key
> > > > combinations and add comments to the log file which is which. This will
> > > > allow me to fix it properly.
> > > 
> > > I hope this is enough.  There are more combinations, I'm sure.  I hope 
> > > that it is one bug causing them all, though.
> > 
> > Perfect, thanks.
> > 
> > Are you possible to reproduce it when you use "i8042_direct" on the
> > kernel command line?
> 
> No, the problem went away.

Good. You can use that for now, and I'll make a fix so that it works
even without it.

-- 
Vojtech Pavlik
SuSE Labs
