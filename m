Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSGVNnz>; Mon, 22 Jul 2002 09:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSGVNnk>; Mon, 22 Jul 2002 09:43:40 -0400
Received: from mark.mielke.cc ([216.209.85.42]:47889 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317171AbSGVNm0>;
	Mon, 22 Jul 2002 09:42:26 -0400
Date: Mon, 22 Jul 2002 09:45:05 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Christoph Hellwig <hch@lst.de>,
       Thunder from the hill <thunder@ngforever.de>, Val Henson <val@nmt.edu>,
       Andreas Schuldei <andreas@schuldei.org>, linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722094505.A20319@mark.mielke.cc>
References: <20020722102930.A14802@lst.de> <Pine.LNX.4.44.0207220443230.3309-100000@hawkeye.luckynet.adm> <20020722124627.A16636@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722124627.A16636@lst.de>; from hch@lst.de on Mon, Jul 22, 2002 at 12:46:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:46:27PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2002 at 04:43:58AM -0600, Thunder from the hill wrote:
> > On Mon, 22 Jul 2002, Christoph Hellwig wrote:
> > > 2.5 _is_ cloned from 2.4..
> > Not exactly.
> Yes, _exactly_.  With BK trees are either cloned or completly separate.

It would have been very foolish to not clone 2.4. Worst case would have
2.5 cloned from 2.3 or 2.2, but the version tree would still be intact,
just a little indirect. (As far as I am aware, 2.5 is cloned from 2.4)

> > Several things have been moved around, note e.g. the 
> > additional "sound" directory...
> What does the movearound of files/directories change?

Nothing, assuming BK is a proper soure management system, which it should be.

In CVS? It would be big problems. But this is one reason why CVS is not
used for real projects such as the Linux Kernel.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

