Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWADVPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWADVPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWADVPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:15:43 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:42219 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751591AbWADVPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:15:42 -0500
Date: Wed, 4 Jan 2006 13:15:26 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       Stefan Rompf <stefan@loplof.de>,
       Clemens Fruhwirth <clemens@endorphin.org>, stable@kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [stable] Re: [Patch 2.6] dm-crypt: zero key before freeing it
Message-ID: <20060104211526.GA12042@kroah.com>
References: <200601042108.04544.stefan@loplof.de> <1136405379.2839.46.camel@laptopd505.fenrus.org> <200601042126.47081.stefan@loplof.de> <Pine.LNX.4.58.0601041228170.19134@shark.he.net> <20060104204129.GA12339@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0601041242270.19134@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601041242270.19134@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 12:43:21PM -0800, Randy.Dunlap wrote:
> On Wed, 4 Jan 2006, J?rn Engel wrote:
> 
> > On Wed, 4 January 2006 12:28:59 -0800, Randy.Dunlap wrote:
> > > On Wed, 4 Jan 2006, Stefan Rompf wrote:
> > > > Am Mittwoch 04 Januar 2006 21:09 schrieb Arjan van de Ven:
> > > >
> > > > > since a memset right before a free is a very unusual code pattern in the
> > > > > kernel it may well be worth putting a short comment around it to prevent
> > > > > someone later removing it as "optimization"
> > > >
> > > > Valid objection, here is an update (and see, I'm running 2.6.15 now ;-)
> > >
> > > A reason "why" would be more helpful that a "what".
> >
> > "prevent information leak"
> >
> > This is still a "what", but at least not a "how".
> 
> OK, that's a much better changelog entry or source code comment...
> if it could be put in one of those places.

Yes, Stefan, care to redo this with an updated changelog command?

thanks,

greg k-h
