Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131520AbRCSRcN>; Mon, 19 Mar 2001 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRCSRcD>; Mon, 19 Mar 2001 12:32:03 -0500
Received: from candygarden.jaj.com ([209.64.26.39]:22534 "EHLO
	disaster.jaj.com") by vger.kernel.org with ESMTP id <S131520AbRCSRbr>;
	Mon, 19 Mar 2001 12:31:47 -0500
Date: Mon, 19 Mar 2001 12:43:45 -0500
From: Phil Edwards <pedwards@disaster.jaj.com>
To: Jakob Østergaard <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: State of RAID (and the infamous FastTrak100 card)
Message-ID: <20010319124345.B29843@disaster.jaj.com>
In-Reply-To: <20010314155801.A7054@disaster.jaj.com> <20010314232714.A19404@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314232714.A19404@unthought.net>; from jakob@unthought.net on Wed, Mar 14, 2001 at 11:27:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 11:27:14PM +0100, Jakob Østergaard wrote:
> However, 2.4 is out and doesn't need patching, and I should probably update the
> howto to reflect that.  But still, most of what's in the HOWTO is as correct as
> it can be.

Okay, I might give that a try.  I'm still scared of 2.4 due to the reports
of filesystem corruption.  (This data is critical, and restoring 80GB of
stuff from tapes on a pseudo-regular basis would not be cool.)

I'm under the impression that I need to do the RAID at either the card
level ("hardware" or "software", whichever we call it), or the software
level described in the HOWTO, but not both...?

(The process under Linux seems to be quite different so far from how we
do it under, say, Solaris, so I might be way off already.)


> > The MAINTAINERS and Documentation/* files don't mention the FastTrack100
> > (not surprising, it's not OSS) nor software RAID (also unsurprising,
> > it's software).
> 
> FastTrack100 RAID *is* software RAID - The software is in the proprietary
> drivers for the card.
> 
> But it's confusing, and Andre Hedrick has already explained this mess on
> several occations here on LKML.   Search the archives.

I did and didn't find much.  What word am I missing in the search terms?
(I found the FastTrak100->what's-the-meaning-of-the-GPL thread I mentioned,
but nothing else.)


Much thanks,
Phil

-- 
pedwards at disaster dot jaj dot com  |  pme at sources dot redhat dot com
devphil at several other less interesting addresses in various dot domains
The gods do not protect fools.  Fools are protected by more capable fools.
