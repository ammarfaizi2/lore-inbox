Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDDSY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDDSY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVDDSY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:24:59 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:34516 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S261236AbVDDSY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:24:56 -0400
X-ME-UUID: 20050404182454571.8B6462800151@mwinf1008.wanadoo.fr
Date: Mon, 4 Apr 2005 20:21:44 +0200
To: Greg KH <greg@kroah.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404182144.GB31055@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050404175130.GA11257@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:51:30AM -0700, Greg KH wrote:
> On Mon, Apr 04, 2005 at 04:16:47PM +0200, Sven Luther wrote:
> > This is just the followup on said discussion, involving the larger LKML
> > audience, in order to get this fixed for good. As said, it is just a mere
> > technicality to get out of the muddy situation, all the people having
> > contributed source-less firmware blobs, need to give us (us being debian, but
> > also all the linux kernel community) either the source if they persist in
> > distributing the code under the GPL, or a clear distribution licence for these
> > firmware blobs, and clearly identificate them as not covered by the GPL that
> > the file they come in is.
> 
> What if we don't want to do so?

You mean, you as copyright holder are not willing to mark the firmware blobs
as not covered by the GPL, then it is simple, the firmware blob in question is
covered by the GPL, and since it lacks source, the whole lot is
non-distributable, and any contributor to the linux kernel can sue
ftp.kernel.org or whoever else is distributing the kernel code. I don't know
if users are able to sue you under the GPL for failing to provide the source
code though.

Seriously, it is just a couple of lines of comments on top of the file, who in
his right mind would object to fixing this issue ? 

> I know I personally posted a solution for this _5_ years ago in debian-legal,
> and have yet to receive a patch...

Well, maybe, but *I* was not there 5 years ago, indeed i believe i didn't even
was remotely connected to the kernel folks inside debian back then, nor even
heard of debian-legal, so i would much like to hear of your proposal, care to
give me a hint about the name of the thread it was in or something ? 

> > Discussing legal issues is all cool and nice for those that appreciates such
> > sport, but it doesn't really make sense if it is not applied to acts later on.
> 
> Then let's see some acts.  We (lkml) are not the ones with the percieved
> problem, or the ones discussing it.

Well, it is currently a violation of the GPL to distribute those firmware
blobs without clearly saying that they are not covered by the GPL. What is the
harm that comes by doing that ? All the other dubious points have been set
aside by the discussion on the thread you probably didn't read. 

Right now, the licencing information is only present in the toplevel COPYRIGHT
file, which is mostly the GPL (excluding user programs :), and since things
like tg3.c which contain such non-free firmware blobs don't say anything else
about the copyright of them, they de-facto fall under the toplevel COPYRIGHT,
including their firmware blobs which lack sources.

All i am asking is that *the copyright holders* of said firmware blobs put a
little comment on top of the files in question saying, all this driver is
GPLed, except the firmware blobs, and we give redistribution rights to said
firmware blobs.

The mention of acts was for the folk at debian-legal who like speaking a lot
in circle and not bring anything forward, which your mention of patches above
confirms :)

Friendly,

Sven Luther

