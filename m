Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbTIKQvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTIKQvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:51:43 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:15844 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261377AbTIKQvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:51:42 -0400
Date: Thu, 11 Sep 2003 18:50:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Stephen Hemminger <shemminger@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
Message-ID: <20030911165059.GC3989@wohnheim.fh-wedel.de>
References: <20030910181847.GO454@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0309101152060.25211-100000@home.osdl.org> <20030910190303.GP454@parcelfarce.linux.theplanet.co.uk> <20030910201607.G30046@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030910201607.G30046@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 September 2003 20:16:07 +0100, Russell King wrote:
> On Wed, Sep 10, 2003 at 08:03:04PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Seriously, though, by now fs/jffs/* has only one real use - extracting
> > data from old filesystem.  IIRC, there was even a talk about having it go
> > the way of ext and xiafs.  He's dead, Jim...
> 
> It isn't that dead - I get the occasional patch from people wanting to keep
> it working, although I really wish people would send them to dwmw2 rather
> than myself.

Yes, it still beats jffs2 in cases where people have <=5 flash blocks
and want a r/w filesystem on them.  Until David, myself or someone
else finds the time to improve jffs2 for corner cases like this, jffs
has a use - sadly.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
