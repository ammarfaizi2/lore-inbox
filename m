Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271388AbTHRLAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271389AbTHRLAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:00:40 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:48071 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271388AbTHRLAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:00:38 -0400
Date: Mon, 18 Aug 2003 13:00:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030818110026.GA29405@ucw.cz>
References: <138e01c364ab$15b6c2b0$1aee4ca5@DIAMONDLX60> <1061141113.21878.76.camel@dhcp23.swansea.linux.org.uk> <151801c36577$10e4f5a0$1aee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151801c36577$10e4f5a0$1aee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 07:35:09PM +0900, Norman Diamond wrote:
> "Alan Cox" <alan@lxorguk.ukuu.org.uk> replied to me.
> 
> > > accept a USB keyboard but they refused.  The patch which I sent to Vojtech
> > > Pavlik was ignored and these two keys continued not to work (except on my
> > > machine).  Finally Mike Fabian accepted a gift of a USB keyboard and this
> > > defect in Linux got fixed.  But only for somewhere around the last half of
> > > the 2.4 releases, not for 2.6.
> > > What will it take this time?
> >
> > Posting the patch with any luck ?
> 
> Hirofumi Ogawa posted a patch for the yen-sign pipe key on 2003.07.23 for
> test1 but his patch still didn't get into test3. 

It will get into 2.6 sooner or later.

> On a PS/2 keyboard that
> seems to be the only key with any problem.
> 
> Yesterday when I finally tried a USB keyboard and found that the backslash
> underbar has the same problem, maybe I was the first person to even try a
> Japanese USB keyboard in 2.6, and maybe no one at all tried some number of
> 2.5 series kernels. 

If you can find out what input event the key generates (using the evtest
program attached), then please tell me, and I'll fix in the same way as
the yen key was fixed.

> As mentioned, usually I can only spend one day a week
> testing 2.6. I'll try to spend one day next weekend trying to figure out
> the new necessary patch.  If I succeed, but if it gets ignored again, I'll
> probably rejoin the set of users who never have time to test.
> 
> I really do think that if Andries Brouwer or Vojtech Pavlik would accept a
> gift of a USB keyboard then this kind of bug would be avoided a lot earlier.

Well, I have a bunch of USB keyboards, all working perfectly. None of
them is a Japanese keyboard, though.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
