Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbULTXOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbULTXOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULTXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:14:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32263 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261687AbULTXC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:02:28 -0500
Date: Tue, 21 Dec 2004 00:02:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dan Dennedy <dan@dennedy.org>, Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220230222.GA21288@stusta.de>
References: <20041220015320.GO21288@stusta.de> <1103508610.3724.69.camel@kino.dennedy.org> <20041220022503.GT21288@stusta.de> <1103510535.1252.18.camel@krustophenia.net> <1103516870.3724.103.camel@kino.dennedy.org> <20041220225324.GY21288@stusta.de> <1103583486.1252.102.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103583486.1252.102.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 05:58:06PM -0500, Lee Revell wrote:
> On Mon, 2004-12-20 at 23:53 +0100, Adrian Bunk wrote:
> > On Sun, Dec 19, 2004 at 11:27:50PM -0500, Dan Dennedy wrote:
> > > On Sun, 2004-12-19 at 21:42 -0500, Lee Revell wrote:
> > > > What do you tell a vendor who wants to write a driver for their device?
> > > > "OK, about half the functions you need are in the kernel, the other half
> > > > you have to port from this old kernel because we removed them.  Maybe we
> > > > will put them back if we really like your driver"?
> > > 
> > > While I think some of Adrian's points are valid, I am exercising caution
> > > because I am a new maintainer for linux1394 (although not new to the
> > > project in general). This is an interface version management issue IMHO.
> > > Adrian is not suggesting to remove the functions yet, but it is
> > > effectively the same thing to an outsider. A vendor or services provider
> > > would have to modify kernel source to let their driver work again, which
> > > is not technically challenging to kernel hackers, but frustrating
> > > situation to be in as a vendor or customer. It creates a mess in
> > > support, distribution, deployment, etc.
> > 
> > The solution is simple:
> > The vendor or services provider submits his driver for inclusion into 
> > the kernel which is the best solution for everyone.
> > 
> 
> What if the driver is under development and doesn't work yet?

For a driver developer, it shouldn't be a big problem to re-add an 
EXPORT_SYMBOL or even to undo an #if 0 of a currently unused function.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

